import pandas as pd
import numpy as np
import sys
import argparse

import sys
import cpuinfo
import subprocess
from subprocess import run
import re
from h3_tools.logger import get_logger
from pathlib import Path

logger = get_logger("h3_battery")


def _counts(density: int):
    assert density % 2 == 0
    return np.unique(
        np.concatenate(
            [
                np.logspace(1, 8.0, density, dtype=np.uint64),
                np.linspace(1, 4 * 10**8, density // 2, dtype=np.uint64),
            ]
        )
    )


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", action=argparse.BooleanOptionalAction)
    parser.add_argument("--match", type=str, default="")
    parser.add_argument("--density", type=int, default=48)
    parser.add_argument("--iterations", type=int, default=3)
    args = parser.parse_args()
    processor = cpuinfo.get_cpu_info()["brand_raw"]
    logger.info(
        f"Benchmarking {processor}"
        + (f" filtered to {args.match}" if args.match != "" else "")
        + (" with profiles" if args.profile else "")
    )
    benchmarks = Path(".") / "bench_results.csv"
    if benchmarks.exists():
        df = pd.read_csv(benchmarks)[lambda idf: idf["duration_seconds"] > 0.0].reset_index(drop=True)
    else:
        df = pd.DataFrame(
            {
                "count": pd.Series([], dtype=int),
                "duration_seconds": pd.Series([], dtype=float),
                "name": pd.Series([], dtype=str),
                "time": pd.Series([], dtype="datetime64[ns, UTC]"),
                "processor": pd.Series([], dtype=str),
            }
        )

    match_clause = "" if args.match == "" else f" --match {args.match}"
    py_spy_path = Path(sys.executable).parents[0] / "py-spy"
    result = subprocess.run(
        f"{sys.executable} bench.py --callables {match_clause}", stdout=subprocess.PIPE, shell=True
    )
    callbacks = [n.strip() for n in result.stdout.decode("utf-8").split(",")]
    max_callback_len = max([len(cb) for cb in callbacks])
    for name in callbacks:
        for count in _counts(args.density):
            if ((df["count"] == count) & (df["name"] == name) & (df["processor"] == processor)).any():
                logger.info(f"Skipping {name: >{max_callback_len}} / {count: >14,} already exists")
                continue
            df_filter = df[
                lambda idf: (idf["name"] == name) & (idf["processor"] == processor) & (idf["count"] <= count)
            ]
            max_duration = df_filter["duration_seconds"].max()

            if max_duration > 60:
                logger.info(
                    f"Skipping {name: >{max_callback_len}} / {count: >14,} as detected {max_duration:.1f} seconds for previous run"
                )
                break

            logger.info(f"Running  {name: >{max_callback_len}} with {count: >14,} points")
            try:
                cmd = f"{sys.executable} bench.py --name {name} --count {count} --iterations {args.iterations}"
                # logger.info(cmd)
                result = subprocess.run(cmd, stdout=subprocess.PIPE, shell=True)
                # logger.info(result.stdout.decode('utf-8'))
                duration_search = re.search(
                    r"in\s+(\d+\.[\w\-]+) seconds", re.sub(r"\s+", " ", result.stdout.decode("utf-8")), re.IGNORECASE
                )
                if not duration_search:
                    logger.warning("Unable to find results")
                    continue
                seconds = float(duration_search.group(1))
                logger.info(f"Result   {name: >{max_callback_len}} -> {seconds:.3f} seconds")
                # check to see if this is the profile candidate - the first entry to require more than 4 seconds
                if (
                    args.profile
                    and seconds >= 4.0
                    and (df["duration_seconds"][((df["name"] == name) & (df["processor"] == processor))] < 4.0).all()
                ):
                    logger.info(f"Result   {name: >{max_callback_len}} Profiling")
                    cmd = f"{sys.executable} -m memray run -o ./bench_memory/{name}.bin bench.py --name {name} --count {count}"
                    result = subprocess.run(cmd, stdout=subprocess.PIPE, shell=True)
                    cmd = f"{sys.executable} -m memray flamegraph ./bench_memory/{name}.bin"
                    result = subprocess.run(cmd, stdout=subprocess.PIPE, shell=True)
                    cmd = f"{py_spy_path} record -f speedscope --native -o ./bench_cpu/{name}.speedscope -- {sys.executable} bench.py --name {name} --count {count}"
                    result = subprocess.run(cmd, stdout=subprocess.PIPE, shell=True)
                    cmd = f"{py_spy_path} record -f flamegraph --native -o ./bench_cpu/{name}.svg -- {sys.executable} bench.py --name {name} --count {count}"
                    result = subprocess.run(cmd, stdout=subprocess.PIPE, shell=True)

                df = (
                    pd.concat(
                        [
                            df,
                            pd.DataFrame(
                                {
                                    "count": pd.Series([count], dtype=int),
                                    "duration_seconds": pd.Series([seconds], dtype=float),
                                    "name": pd.Series([name], dtype=str),
                                    "time": pd.Series([pd.Timestamp.now()], dtype="datetime64[ns, UTC]"),
                                    "processor": pd.Series([processor], dtype=str),
                                }
                            ),
                        ]
                    )
                    .sort_values(["name", "count"])
                    .reset_index(drop=True)
                )
                df.to_csv(benchmarks, index=False)
            except Exception as why:
                logger.error("Failure")
                logger.error(name, count)
                logger.error(cmd)
                logger.error(why)


if __name__ == "__main__":
    main()
