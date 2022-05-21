import numpy as np
import warnings

with warnings.catch_warnings():
    warnings.filterwarnings("ignore", category=UserWarning)
    import h3.unstable.vect as h3_vect  # h3 helpfully and correctly notes this is unstable


def vectorized(points: np.ndarray, resolution: int) -> np.ndarray:
    return h3_vect.geo_to_h3(points[:, 0], points[:, 1], resolution)
