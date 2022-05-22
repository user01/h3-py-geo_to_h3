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
    lon = np.ascontiguousarray(points[:, 1], dtype=np.float32)
    result = h3cuda.geo_to_h3_distinct(lat, lon, resolution, blocks, threads)
    assert result.dtype == np.uint64
    return result


def cuda_unified(points: np.ndarray, resolution: int, blocks: int = 64, threads: int = 32) -> np.ndarray:
    if not CUDA_AVAILABLE:
        raise ImportError("Cuda package not available")
    result = h3cuda.geo_to_h3_unified(points, resolution, blocks, threads)
    assert result.dtype == np.uint64
    return result
