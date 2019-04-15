#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>;﻿

using namespace std;

__global__ void AddIntsCuda(int *a, int *b)
{
	int i = threadIdx.x;
	a[i] += b[i];
}

__global__ void InterChangeCuda(int *a, int *b)
{
	 int i = threadIdx.x;
	int temp = a[i];
	a[i] = b[i];
	b[i] = a[i];
}


int main() {
	int a = 5, b = 9;
	int *d_a, *d_b;

	cudaMalloc(&d_a, sizeof(int));
	cudaMalloc(&d_b, sizeof(int));

	cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

	AddIntsCuda<<< 1, 1 >>>(d_a, d_b);

	cudaMemcpy(&a, d_a, sizeof(int), cudaMemcpyDeviceToHost);

	cout << "The result is: " << a << endl;

	cudaFree(d_a);
	cudaFree(d_b);

	return 0;
}

