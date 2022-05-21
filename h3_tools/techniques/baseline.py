import numpy as np
from h3 import h3


def baseline(points: np.ndarray, resolution: int) -> np.ndarray:
    # Simplest example based on docs
    h3_ints = []
    for lat, lon in points:
        i = int(h3.geo_to_h3(lat, lon, resolution), 16)
        h3_ints.append(i)
    return np.array(h3_ints, dtype=np.uint64)
