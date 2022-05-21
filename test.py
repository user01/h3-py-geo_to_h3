import numpy as np
import pytest

from h3_tools.techniques.baseline import baseline
from h3_tools.techniques.api import integer, numpy_int, memview_int
from h3_tools.techniques.vectorized import vectorized
from h3_tools.techniques.cuda import cuda, cuda_unified, CUDA_AVAILABLE
from h3_tools.techniques.pandas import pandas, pandas_int
from h3_tools.techniques.distribute import threadpool, pool, pool_vector, threadpool_vector
from h3_tools.benchmark import generate_lat_lon_points


def test_baseline():
    res = baseline(np.array([[37.7955, -122.3937]]), 10)  # taken from the h3 docs
    np.testing.assert_almost_equal(res, np.array([int("8a283082a677fff", 16)]))


def _test_callable(callable):
    points = generate_lat_lon_points(count=200, seed=0)
    np.testing.assert_allclose(callable(points, 4), baseline(points, 4))
    points = generate_lat_lon_points(count=2000, seed=0)
    np.testing.assert_allclose(callable(points, 7), baseline(points, 7))


def test_pandas():
    _test_callable(pandas)


def test_pandas_int():
    _test_callable(pandas_int)


def test_integer():
    _test_callable(integer)


def test_numpy_int():
    _test_callable(numpy_int)


def test_memview_int():
    _test_callable(memview_int)


def test_vectorized():
    _test_callable(vectorized)


@pytest.mark.skipif(not CUDA_AVAILABLE, reason="CUDA not available")
def test_cuda():
    _test_callable(cuda)


@pytest.mark.skipif(not CUDA_AVAILABLE, reason="CUDA not available")
def test_cuda_unified():
    _test_callable(cuda_unified)


def test_threadpool():
    _test_callable(threadpool)


def test_pool():
    _test_callable(pool)


def test_pool_vector():
    _test_callable(pool_vector)


def test_threadpool_vector():
    _test_callable(threadpool_vector)
