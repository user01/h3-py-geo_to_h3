import pandas as pd
import cpuinfo


def get_keepers(idf):
    return idf[
        lambda idf: (idf["name"].str.contains("_64_64") | idf["name"].str.contains("_2048_128"))
        & ~idf["name"].str.contains("_f32")
    ]


def cudify(data):
    data_non_cuda = data[lambda idf: ~idf["name"].str.contains("cuda")]
    data_cuda = data[lambda idf: idf["name"].str.contains("cuda")]
    if data_cuda.shape[0] < 1:
        return data

    data_cuda_normal = data_cuda[~data_cuda["name"].str.contains("unified")].pipe(get_keepers)
    data_cuda_unified = data_cuda[data_cuda["name"].str.contains("unified")].pipe(get_keepers)

    return pd.concat([data_non_cuda, data_cuda_normal, data_cuda_unified])


def main():

    df = (
        pd.read_csv("bench_results.csv")
        .groupby(["name", "processor", "count"])
        .mean()
        .reset_index()
        .assign(pts_per_sec=lambda idf: idf["count"] / idf["duration_seconds"])
    )
    results = pd.concat([cudify(data) for _, data in df.groupby("processor")])[
        lambda idf: idf["processor"] == cpuinfo.get_cpu_info()["brand_raw"]
    ].reset_index(drop=True)
    results.to_csv("results.csv", index=False)


if __name__ == "__main__":
    main()
