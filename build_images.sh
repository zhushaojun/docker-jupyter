#!/bin/bash

py_versions=(3.7 3.8 3.9)
# cuda_version=(11.4.2-cudnn8-runtime-ubuntu20.04
# https://hub.docker.com/r/nvidia/cuda/tags

for py in 3.7 3.8 3.9
do
	image=cuda-scipy:$py
	docker build --build-arg PYTHON_VERSION=$py --tag $image ./scipy
	docker tag $image zhushaojun/$image
	docker push zhushaojun/$image

	for i in auto-sklearn mxnet pycaret pytorch tensorflow
	do
		docker build --build-arg BASE_CONTAINER=$image --tag $i:$py ./$i
		docker tag $i:$py zhushaojun/$i:$py
		docker push zhushaojun/$i:$py
	done
done
