import numpy as np
import h3.api.basic_int as h3_basic_int
import h3.api.numpy_int as h3_numpy_int
import h3.api.memview_int as h3_memview_int


def integer(points: np.ndarray, resolution: int) -> np.ndarray:
    h3_ints = []
    for lat, lon in points:
        h3_ints.append(h3_basic_int.geo_to_h3(lat, lon, resolution))
    return np.array(h3_ints, dtype=np.uint64)


def numpy_int(points: np.ndarray, resolution: int) -> np.ndarray:
    h3_ints = np.zeros(points.shape[0], dtype=np.uint64)
    for idx, (lat, lon) in enumerate(points):
        h3_ints[idx] = h3_numpy_int.geo_to_h3(lat, lon, resolution)
    return h3_ints


def memview_int(points: np.ndarray, resolution: int) -> np.ndarray:
    h3_ints = np.zeros(points.shape[0], dtype=np.uint64)
    for idx, (lat, lon) in enumerate(points):
        h3_ints[idx] = h3_memview_int.geo_to_h3(lat, lon, resolution)
    return h3_ints
