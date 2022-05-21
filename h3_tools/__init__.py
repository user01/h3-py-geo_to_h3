from functools import partial, lru_cache
import itertools

from .techniques.baseline import baseline
from .techniques.api import integer, numpy_int, memview_int
from .techniques.vectorized import vectorized
from .techniques.cuda import cuda, cuda_unified, CUDA_AVAILABLE
from .techniques.pandas import pandas, pandas_int
from .techniques.distribute import threadpool, pool, pool_vector, threadpool_vector
from .logger import get_logger

logger = get_logger("h3_benchmark")


@lru_cache
def callbacks():
    if CUDA_AVAILABLE:
        blocks = [32, 64, 128, 256, 512, 1024, 2048]
        threads = [16, 32, 64, 128, 256]
        blocks_threads = list(itertools.product(blocks, threads))
        cuda_callbacks = {
            **{
                f"cuda_{blocks}_{threads}": partial(cuda, blocks=blocks, threads=threads)
                for (blocks, threads) in blocks_threads
            },
            **{
                f"cuda_unified_{blocks}_{threads}": partial(cuda_unified, blocks=blocks, threads=threads)
                for (blocks, threads) in blocks_threads
            },
            **{
                f"cuda_unified_{blocks}_{threads}_f32": partial(cuda_unified, blocks=blocks, threads=threads)
                for (blocks, threads) in blocks_threads
            },
        }
    else:
        cuda_callbacks = {}

    cbs = {
        **{
            "baseline": baseline,
            "pandas": pandas,
            "pandas_int": pandas_int,
            "integer": integer,
            "numpy_int": numpy_int,
            "memview_int": memview_int,
            "vectorized": vectorized,
            "threadpool_2": partial(threadpool, workers=2),
            "threadpool_4": partial(threadpool, workers=4),
            "threadpool_8": partial(threadpool, workers=8),
            "threadpool_16": partial(threadpool, workers=16),
            "pool_2": partial(pool, workers=2),
            "pool_4": partial(pool, workers=4),
            "pool_8": partial(pool, workers=8),
            "pool_16": partial(pool, workers=16),
            "pool_vector_2": partial(pool_vector, workers=2),
            "pool_vector_4": partial(pool_vector, workers=4),
            "pool_vector_8": partial(pool_vector, workers=8),
            "pool_vector_16": partial(pool_vector, workers=16),
            "threadpool_vector_2": partial(threadpool_vector, workers=2),
            "threadpool_vector_4": partial(threadpool_vector, workers=4),
            "threadpool_vector_8": partial(threadpool_vector, workers=8),
            "threadpool_vector_16": partial(threadpool_vector, workers=16),
        },
        **cuda_callbacks,
    }
    return cbs
