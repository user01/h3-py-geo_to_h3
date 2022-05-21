# https://github.com/uber/h3-py/blob/c3593ecae5796526f9c6dc7dc140c7df2251a7f2/src/h3/unstable/vect.py
# https://github.com/uber/h3-py/blob/c3593ecae5796526f9c6dc7dc140c7df2251a7f2/src/h3/_cy/geo.pyx
# https://github.com/uber/h3/blob/e0aae450ffa7a63a3b7982573c88325b42231332/src/h3lib/lib/h3Index.c
# https://github.com/uber/h3/blob/e0aae450ffa7a63a3b7982573c88325b42231332/src/h3lib/lib/faceijk.c
# https://uber.github.io/h3-py/api_comparison
# https://github.com/uber/h3-py-notebooks/blob/master/notebooks/time_h3_apis.ipynb
# file:///Users/erik/code/python/h3-exercise/example-classification.html
# https://www.construct.net/en/blogs/ashleys-blog-2/porting-webgl-shaders-webgpu-1576

import warnings
import argparse

warnings.filterwarnings("error")  # warnings are errors

from h3_tools.logger import get_logger
from h3_tools import callbacks
from h3_tools.benchmark import benchmark_single

logger = get_logger("h3_benchmark")


# Purpose: How to optimize an operation from a python project

# Understand the objective and purpose
# Start with the domain
# quick demo of h3's purpose and logic


def single():
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", type=str, default=list(callbacks().keys())[0])
    parser.add_argument("--count", type=int, default=0)
    parser.add_argument("--iterations", type=int, default=3)
    parser.add_argument("--match", type=str, default="")
    parser.add_argument("--callables", action=argparse.BooleanOptionalAction)
    parser.add_argument("--float32", action=argparse.BooleanOptionalAction)
    args = parser.parse_args()
    cbs = {k: v for k, v in callbacks().items() if args.match == "" or args.match in k}
    if args.callables:
        print(",".join(list(cbs.keys())))
        return
    if args.name not in cbs.keys():
        raise ValueError(f"Unable to find {args.name} in callbacks")
    if not (0 <= args.count < 1e9):
        raise ValueError(f"Invalid count of {args.count}")
    benchmark_single(
        args.name,
        args.count,
        precast_to_float32=args.float32 or args.name.endswith("_f32"),
        iterations=args.iterations,
    )


if __name__ == "__main__":
    single()
