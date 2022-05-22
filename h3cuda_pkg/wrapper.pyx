import logging
import numpy as np
cimport numpy as npc
from numpy cimport uint64_t

assert sizeof(float) == sizeof(npc.float32_t)

cdef extern from "src/manager.hh":
    cdef cppclass C_latLngToCell_Distinct "latLngToCell_Distinct":
        C_latLngToCell_Distinct(npc.float32_t*, npc.float32_t*, npc.uint64_t*, int, int, int, int)
    cdef cppclass C_latLngToCell_Unified "latLngToCell_Unified":
        C_latLngToCell_Unified(npc.float32_t*, npc.uint64_t*, int, int, int, int)


cdef class LatLngToCell_Distinct:
    cdef C_latLngToCell_Distinct* g
    cdef int dim1
    cdef public npc.ndarray idxs

    def __cinit__(
        self,
        npc.ndarray[ndim=1, dtype=npc.float32_t] lat,
        npc.ndarray[ndim=1, dtype=npc.float32_t] lng,
        int resolution,
        int blocks=2048,
        int threads=128,
    ):
        self.dim1 = len(lat)
        cdef npc.ndarray[ndim=1, dtype=npc.uint64_t] idxs = np.zeros(self.dim1, dtype=np.uint64)
        self.g = new C_latLngToCell_Distinct(&lat[0], &lng[0], &idxs[0], self.dim1, resolution, blocks, threads)
        self.idxs = idxs

def geo_to_h3_distinct(lat:np.ndarray, lng:np.ndarray, resolution:int, blocks:int=2048, threads:int=128) -> np.ndarray:
    """
    Indexes the location at the specified resolution, returning the index of the cell containing the location.
    This buckets the geographic point into the H3 grid.

    For optimal performance, `lat` and `lng` should be np.float32 and C_CONTIGUOUS
    If not, the system will align before the operation is performed

    If data is available in a single (n,2) array, consider `geo_to_h3_unified` as an alternative

    Parameters
    ----------
    lat : np.ndarray
        WGS Latitude
    lng : np.ndarray
        WGS Longitude
    resolution : int
        H3 Resolution
    blocks : int
        CUDA blocks for the operation, default 2048
    resolution : int
        CUDA threads for each block, default 128

    Returns
    -------
    np.ndarray
        H3 Resolutions - np.uint64
    """
    assert 0 <= resolution <= 15, "Invalid resolution"
    assert len(lat.shape) == 1, "Latitude must be of shape (n,)"
    assert len(lng.shape) == 1, "Longitude must be of shape (n,)"
    assert len(lat) == len(lng), "Latitude and Longitude must be of the same length"
    lat = lat if lat.flags['C_CONTIGUOUS'] and lat.dtype == np.float32 else np.ascontiguousarray(lat, dtype=np.float32)
    lng = lng if lng.flags['C_CONTIGUOUS'] and lng.dtype == np.float32 else np.ascontiguousarray(lng, dtype=np.float32)
    op = LatLngToCell_Distinct(lat, lng, resolution)
    result = op.idxs
    assert result.dtype == np.uint64
    return result


cdef class LatLngToCell_Unified:
    cdef C_latLngToCell_Unified* g
    cdef int dim1
    cdef public npc.ndarray idxs

    def __cinit__(
        self,
        npc.ndarray[ndim=1, dtype=npc.float32_t] data,
        int resolution,
        int blocks=2048,
        int threads=128,
    ):
        assert len(data) % 2 == 0, "Must be in lat/lng pairs"
        cdef npc.ndarray[ndim=1, dtype=npc.float32_t] pts = (
            data
            if data.flags["C_CONTIGUOUS"]
            else np.ascontiguousarray(data, dtype=np.float32)
        )
        self.dim1 = len(pts) // 2
        cdef npc.ndarray[ndim=1, dtype=npc.uint64_t] idxs = np.zeros(self.dim1, dtype=np.uint64)
        self.g = new C_latLngToCell_Unified(&pts[0], &idxs[0], self.dim1, resolution, blocks, threads)
        self.idxs = idxs

def geo_to_h3_unified(points:np.ndarray, resolution:int, blocks:int=2048, threads:int=128) -> np.ndarray:
    """
    Indexes the location at the specified resolution, returning the index of the cell containing the location.
    This buckets the geographic point into the H3 grid.

    For optimal performance, `points` should be np.float32 and C_CONTIGUOUS
    If not, the system will align before the operation is performed

    If data is available in a two (n,) arrays, consider `geo_to_h3_distinct` as an alternative

    Parameters
    ----------
    points : np.ndarray
        WGS Latitude/Longitude, (n,2)
    resolution : int
        H3 Resolution
    blocks : int
        CUDA blocks for the operation, default 2048
    resolution : int
        CUDA threads for each block, default 128

    Returns
    -------
    np.ndarray
        H3 Resolutions - (n,) np.uint64
    """
    assert 0 <= resolution <= 15, "Invalid resolution"
    assert len(points.shape) == 2, "Points must be of shape (n,2) with lat/lng pattern"
    pts_32 = points if points.dtype == np.float32 else points.astype(np.float32)
    pts_flat = pts_32 if pts_32.flags["C_CONTIGUOUS"] else np.ascontiguousarray(pts_32, dtype=np.float32)
    op = LatLngToCell_Unified(pts_flat.reshape(-1), resolution)
    result = op.idxs
    assert result.dtype == np.uint64
    return result
