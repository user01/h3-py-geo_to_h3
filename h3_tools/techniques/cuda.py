import numpy as np

try:
    import h3cuda

    CUDA_AVAILABLE = True
except ImportError:
    CUDA_AVAILABLE = False


def cuda(points: np.ndarray, resolution: int, blocks: int = 64, threads: int = 32) -> np.ndarray:
    if not CUDA_AVAILABLE:
        raise ImportError("Cuda package not available")
    lat = np.ascontiguousarray(points[:, 0], dtype=np.float32)
    # Note this could be (somewhat?) faster if the signature changed
    lon = np.ascontiguousarray(points[:, 1], dtype=np.float32)
    op = h3cuda.GPUH3_latLngToCell(lat, lon, resolution, blocks, threads)
    result = op.idxs
    assert result.dtype == np.uint64
    return result


def cuda_unified(points: np.ndarray, resolution: int, blocks: int = 64, threads: int = 32) -> np.ndarray:
    if not CUDA_AVAILABLE:
        raise ImportError("Cuda package not available")
    pts = (
        points
        if points.flags["C_CONTIGUOUS"] and points.dtype == np.float32
        else np.ascontiguousarray(points, dtype=np.float32)
    )
    op = h3cuda.Unified(pts.reshape(-1), resolution, blocks, threads)
    result = op.idxs
    assert result.dtype == np.uint64
    return result
