#include <assert.h>
#include <inttypes.h>
#include <iostream>
#include <kernel.cu>
#include <manager.hh>
#include <stdio.h>
#include <utility.cu>
using namespace std;

latLngToCell_Distinct::latLngToCell_Distinct(float *lat_h_, float *lon_h_,
                                             uint64_t *idx_h_, int length_,
                                             int resolution, uint blocks = 64,
                                             uint threads = 32) {
  lat_h = lat_h_;
  lon_h = lon_h_;
  idx_h = idx_h_;
  length = length_;
  size_t byte_float = length * sizeof(float);
  size_t byte_uint64 = length * sizeof(uint64_t);

  gpuErrchk(cudaMalloc((float **)&lat_d, byte_float));
  gpuErrchk(cudaMalloc((float **)&lon_d, byte_float));
  gpuErrchk(cudaMalloc((uint64_t **)&idx_d, byte_uint64));

  gpuErrchk(cudaMemcpy(lat_d, lat_h, byte_float, cudaMemcpyHostToDevice));
  gpuErrchk(cudaMemcpy(lon_d, lon_h, byte_float, cudaMemcpyHostToDevice));

  // Blocks, Threads
  kernel_h3<<<blocks, threads>>>(lat_d, lon_d, idx_d, length, resolution);
  gpuErrchk(cudaDeviceSynchronize());
  gpuErrchk(cudaPeekAtLastError());

  gpuErrchk(cudaMemcpy(idx_h_, idx_d, byte_uint64, cudaMemcpyDeviceToHost));

  gpuErrchk(cudaFree(lat_d));
  gpuErrchk(cudaFree(lon_d));
  gpuErrchk(cudaFree(idx_d));
}

latLngToCell_Distinct::~latLngToCell_Distinct() {}

latLngToCell_Unified::latLngToCell_Unified(float *data_h, uint64_t *idx_h,
                                           int length, int resolution,
                                           uint blocks = 64,
                                           uint threads = 32) {
  size_t byte_float = 2 * length * sizeof(float);
  size_t byte_uint64 = length * sizeof(uint64_t);
  float *data_d;
  uint64_t *idx_d;

  gpuErrchk(cudaMalloc((float **)&data_d, byte_float));
  gpuErrchk(cudaMalloc((uint64_t **)&idx_d, byte_uint64));

  gpuErrchk(cudaMemcpy(data_d, data_h, byte_float, cudaMemcpyHostToDevice));

  // Blocks, Threads
  kernel_h3_unified<<<blocks, threads>>>(data_d, idx_d, length, resolution);
  gpuErrchk(cudaDeviceSynchronize());
  gpuErrchk(cudaPeekAtLastError());

  gpuErrchk(cudaMemcpy(idx_h, idx_d, byte_uint64, cudaMemcpyDeviceToHost));

  gpuErrchk(cudaFree(data_d));
  gpuErrchk(cudaFree(idx_d));
}

latLngToCell_Unified::~latLngToCell_Unified() {}