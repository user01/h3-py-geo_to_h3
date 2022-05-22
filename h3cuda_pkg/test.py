import numpy as np

import pytest
import h3
import h3.api.basic_int as h3_int
import h3cuda
from shapely.geometry import Polygon, Point
from shapely.ops import nearest_points


def generate_lat_lon_points(count: int = 50, seed: int = 0) -> np.ndarray:
    rng = np.random.default_rng(seed)
    latitudes = (rng.random(count) * 2 - 1) * 90.0
    longitudes = (rng.random(count) * 2 - 1) * 180.0
    return np.concatenate([latitudes.reshape(-1, 1), longitudes.reshape(-1, 1)], axis=1)


def points_to_h3_int(points: np.ndarray, resolution: int) -> np.ndarray:
    h3_ints = []
    for lat, lon in points:
        h3_ints.append(h3_int.geo_to_h3(lat, lon, resolution))
    return np.array(h3_ints, dtype=np.uint64)


def points_to_h3_cuda_distinct(points: np.ndarray, resolution: int) -> np.ndarray:
    lat = points[:, 0]
    lng = points[:, 1]
    result = h3cuda.geo_to_h3_distinct(lat.astype(np.float32), lng.astype(np.float32), resolution)
    assert result.dtype == np.uint64
    return result


def points_to_h3_cuda_unified(points: np.ndarray, resolution: int) -> np.ndarray:
    result = h3cuda.geo_to_h3_unified(points, resolution)
    assert result.dtype == np.uint64
    return result


BENCHMARK_SIZE = 800_000


@pytest.mark.benchmark(group="points")
def test_unified_f32_contiguous(benchmark):
    pts = np.ascontiguousarray(generate_lat_lon_points(BENCHMARK_SIZE), dtype=np.float32)
    actual = benchmark.pedantic(h3cuda.geo_to_h3_unified, args=(pts, 6), warmup_rounds=1, rounds=6, iterations=12)
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_unified_f64_contiguous(benchmark):
    pts = np.ascontiguousarray(generate_lat_lon_points(BENCHMARK_SIZE), dtype=np.float64)
    actual = benchmark.pedantic(h3cuda.geo_to_h3_unified, args=(pts, 6), warmup_rounds=1, rounds=6, iterations=12)
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_unified_f64_noncontiguous(benchmark):
    pts = generate_lat_lon_points(BENCHMARK_SIZE * 2).astype(np.float64)[::2]
    actual = benchmark.pedantic(h3cuda.geo_to_h3_unified, args=(pts, 6), warmup_rounds=1, rounds=6, iterations=12)
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_unified_f32_noncontiguous(benchmark):
    pts = generate_lat_lon_points(BENCHMARK_SIZE * 2).astype(np.float32)[::2]
    actual = benchmark.pedantic(h3cuda.geo_to_h3_unified, args=(pts, 6), warmup_rounds=1, rounds=6, iterations=12)
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_distinct_f32_contiguous(benchmark):
    pts = np.ascontiguousarray(generate_lat_lon_points(BENCHMARK_SIZE), dtype=np.float32)
    lat = np.ascontiguousarray(pts[:, 0], dtype=np.float32)
    lng = np.ascontiguousarray(pts[:, 1], dtype=np.float32)
    actual = benchmark.pedantic(
        h3cuda.geo_to_h3_distinct, args=(lat, lng, 6), warmup_rounds=1, rounds=6, iterations=12
    )
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_distinct_f64_contiguous(benchmark):
    pts = np.ascontiguousarray(generate_lat_lon_points(BENCHMARK_SIZE), dtype=np.float64)
    lat = np.ascontiguousarray(pts[:, 0], dtype=np.float64)
    lng = np.ascontiguousarray(pts[:, 1], dtype=np.float64)
    actual = benchmark.pedantic(
        h3cuda.geo_to_h3_distinct, args=(lat, lng, 6), warmup_rounds=1, rounds=6, iterations=12
    )
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_distinct_f64_noncontiguous(benchmark):
    pts = generate_lat_lon_points(BENCHMARK_SIZE * 2).astype(np.float64)[::2]
    lat = pts[:, 0]
    lng = pts[:, 1]
    actual = benchmark.pedantic(
        h3cuda.geo_to_h3_distinct, args=(lat, lng, 6), warmup_rounds=1, rounds=6, iterations=12
    )
    assert actual.shape[0] == pts.shape[0]


@pytest.mark.benchmark(group="points")
def test_distinct_f32_noncontiguous(benchmark):
    pts = generate_lat_lon_points(BENCHMARK_SIZE * 2).astype(np.float32)[::2]
    lat = pts[:, 0]
    lng = pts[:, 1]
    actual = benchmark.pedantic(
        h3cuda.geo_to_h3_distinct, args=(lat, lng, 6), warmup_rounds=1, rounds=6, iterations=12
    )
    assert actual.shape[0] == pts.shape[0]


def test_h3_many():
    pts = np.ascontiguousarray(generate_lat_lon_points(200_000), dtype=np.float32)
    for res in range(0, 16):
        offsets = 0
        edge_length = h3.edge_length(res, unit="m")
        apothem = (3**0.5 / 2) * edge_length  # roughly the radius

        res_expected = points_to_h3_int(pts, res)
        res_actual = points_to_h3_cuda_unified(pts, res)
        for idx, (r_expected, r_actual) in enumerate(zip(res_expected, res_actual, strict=True)):
            if r_expected != r_actual:
                diff = h3_int.h3_distance(r_expected, r_actual)
                assert diff == 1  # if not identical, then they should be a rounding error neighbors

                # check that the error is small enough compared to the resolution
                pt = pts[idx]
                boundary = h3_int.h3_to_geo_boundary(r_expected, geo_json=False)
                p1, _ = nearest_points(Polygon(boundary), Point(pt))
                distance_from_hex = h3.point_dist(pt, np.array(p1.coords)[0], unit="m")
                assert distance_from_hex / apothem < 1e-3, "Too far from hex"

                offsets += 1  # record for overall count check

        assert offsets / pts.shape[0] < 0.01


def test_h3_few():
    pts = generate_lat_lon_points(200)
    for res in [4, 7, 9]:
        res_h3 = points_to_h3_int(pts, res)
        res_cuda = points_to_h3_cuda_distinct(pts, res)
        np.testing.assert_equal(res_h3, res_cuda)


def test_h3_few_simple():
    pts = generate_lat_lon_points(7, 3)
    res = 4
    res_h3 = points_to_h3_int(pts, res)
    res_cuda = points_to_h3_cuda_distinct(pts, res)
    np.testing.assert_equal(res_h3, res_cuda)


def test_h3_unified_few_simple():
    pts = generate_lat_lon_points(7, 3)
    res = 4
    res_h3 = points_to_h3_int(pts, res)
    res_cuda = points_to_h3_cuda_unified(pts, res)
    np.testing.assert_equal(res_h3, res_cuda)


def test_h3_valid():
    pts = generate_lat_lon_points(7_000, seed=3)
    for res in [4, 7, 9]:
        res_cuda = points_to_h3_cuda_distinct(pts, res)
        for h in res_cuda:
            assert h3_int.h3_is_valid(h)


def test_h3_init():
    # lat, lon, res
    lat, lon = [37.3615593, -122.0553238]
    res = 9
    h3_address = h3.geo_to_h3(lat, lon, res)
    assert "89283470d93ffff" == h3_address
    h3_address_int = h3_int.geo_to_h3(lat, lon, res)
    assert h3_address_int == int(h3_address, 16)
    assert h3_int_to_str(h3_address_int) == h3_address

    arr_lat = np.array(
        [
            lat,
        ],
        dtype=np.float32,
    )
    arr_lon = np.array(
        [
            lon,
        ],
        dtype=np.float32,
    )
    op = h3cuda.LatLngToCell_Distinct(arr_lat, arr_lon, res)
    result = op.idxs
    assert result.dtype == np.uint64
    assert result.shape[0] == arr_lat.shape[0]
    assert result[0] == h3_address_int


def h3_int_to_str(h3_address_int: int) -> str:
    return f"{h3_address_int:0>4X}".lower()
