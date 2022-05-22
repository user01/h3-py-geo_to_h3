import numpy as np
from concurrent.futures import ThreadPoolExecutor
from multiprocess import Pool

from .vectorized import vectorized
from .api import integer
import os


_CPU_COUNT = os.cpu_count()


def threadpool(points: np.ndarray, resolution: int, workers: int = None) -> np.ndarray:
    workers = workers if workers else _CPU_COUNT
    payload = np.array_split(points, workers) if points.shape[0] > workers else [points]
    with ThreadPoolExecutor(workers) as executor:
        futures = [executor.submit(integer, pts, resolution) for pts in payload]
    return np.concatenate([f.result() for f in futures])


def pool(points: np.ndarray, resolution: int, workers: int = None) -> np.ndarray:
    workers = workers if workers else _CPU_COUNT
    payload = np.array_split(points, workers) if points.shape[0] > workers else [points]
    with Pool(workers) as pool:
        results = pool.map(lambda pts: integer(pts, resolution=resolution), payload)
    return np.concatenate(results)


def pool_vector(points: np.ndarray, resolution: int, workers: int = None) -> np.ndarray:
    workers = workers if workers else _CPU_COUNT
    payload = np.array_split(points, workers) if points.shape[0] > workers else [points]
    with Pool(workers) as pool:
        results = pool.map(lambda pts: vectorized(pts, resolution=resolution), payload)
    return np.concatenate(results)


def threadpool_vector(points: np.ndarray, resolution: int, workers: int = None) -> np.ndarray:
    workers = workers if workers else _CPU_COUNT
    payload = np.array_split(points, workers) if points.shape[0] > workers else [points]
    # note the payloads are np views (or tiny)
    with ThreadPoolExecutor(workers) as executor:
        futures = [executor.submit(vectorized, pts, resolution) for pts in payload]
    return np.concatenate([f.result() for f in futures])
