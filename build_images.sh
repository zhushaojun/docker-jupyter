#!/bin/bash

py_versions=(3.7 3.8 3.9)
# cuda_version=(11.4.2-cudnn8-runtime-ubuntu20.04
# https://hub.docker.com/r/nvidia/cuda/tags

chmod +x scipy/*.sh
chmod +x scipy/fix-permissions

# gpu notebook
for py in 3.7 3.8 3.9
do
	image=cuda-scipy:$py
	docker build --build-arg PYTHON_VERSION=$py --tag $image ./scipy
	docker tag $image zhushaojun/$image
	docker push zhushaojun/$image

	for image_name in mxnet pytorch tensorflow
	do
		date=$(date '+%Y%m%d-%H%M%S')
		tagname=$image_name:$py
		docker build --build-arg BASE_CONTAINER=$image --tag $tagname ./$image_name
		docker tag $tagname zhushaojun/$tagname
		docker push zhushaojun/$tagname
	done
done

# cpu notebook
for image_name in auto-sklearn pycaret
do
	date=$(date '+%Y%m%d-%H%M%S')
	tagname=$image_name:$date
	docker build --tag $tagname ./$image_name
	docker tag $tagname zhushaojun/$tagname
	docker push zhushaojun/$tagname
done
