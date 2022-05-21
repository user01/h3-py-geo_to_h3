import pandas as pd
import numpy as np
from h3 import h3
import h3.api.basic_int as h3_basic_int

# pandas iterrows
def pandas(points: np.ndarray, resolution: int) -> np.ndarray:
    df = pd.DataFrame(points, columns=["Latitude", "Longitude"])
    h3_ints = []
    for _, row in df.iterrows():
        lat = row["Latitude"]
        lon = row["Longitude"]
        i = int(h3.geo_to_h3(lat, lon, resolution), 16)
        h3_ints.append(i)
    return np.array(h3_ints, dtype=np.uint64)


# pandas iterrows int
def pandas_int(points: np.ndarray, resolution: int) -> np.ndarray:
    df = pd.DataFrame(points, columns=["Latitude", "Longitude"])
    h3_ints = []
    for _, row in df.iterrows():
        lat = row["Latitude"]
        lon = row["Longitude"]
        i = h3_basic_int.geo_to_h3(lat, lon, resolution)
        h3_ints.append(i)
    return np.array(h3_ints, dtype=np.uint64)
