from pathlib import Path
import numpy as np
from typing import Callable
from timeit import Timer

from .logger import get_logger
from . import callbacks

logger = get_logger("h3_benchmark")


def generate_lat_lon_points(count: int = 50, seed: int = 0) -> np.ndarray:
    rng = np.random.default_rng(seed)
    latitudes = (rng.random(count) * 2 - 1) * 90.0
    longitudes = (rng.random(count) * 2 - 1) * 180.0
    return np.concatenate([latitudes.reshape(-1, 1), longitudes.reshape(-1, 1)], axis=1)


def timeit_local(callable, iterations=3):
    t = Timer(callable)  # lambda introduces a slight overhead for each call
    return t.timeit(number=iterations) / iterations


def benchmark_points(
    callable: Callable,
    count: int = 50,
    resolution: int = 4,
    seed: int = 0,
    precast_to_float32: bool = False,
    iterations: int = 3,
):
    points = generate_lat_lon_points(count=count, seed=seed)
    pts = points if precast_to_float32 else np.ascontiguousarray(points, dtype=np.float32)
    wrapped = lambda: callable(pts, resolution=resolution)
    duration_seconds = timeit_local(wrapped, iterations=iterations)
    return duration_seconds


def benchmark_single(name, count, precast_to_float32=False, iterations: int = 3) -> bool:
    logger.info(f"{name: >18} {count: >9,} started")
    root = Path(".") / f"benchmarks"
    root.mkdir(parents=True, exist_ok=True)
    path = root / f"{name}-{count}.csv"
    if path.exists():
        logger.info(f"{name: >18} {count: >9,} exists")
        return False
    callable = callbacks()[name]
    duration_seconds = benchmark_points(
        callable=callable,
        count=count,
        seed=count,
        precast_to_float32=precast_to_float32,
        iterations=iterations,
    )
    logger.info(
        f"{name: >18} {count: >9,} in {duration_seconds} seconds. {(count/1_000_000)/duration_seconds: >4.1f}MMpt/s"
    )
    return True
