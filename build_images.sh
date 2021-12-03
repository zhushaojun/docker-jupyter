#!/bin/bash

# cuda_version=(11.4.2-cudnn8-runtime-ubuntu20.04
# https://hub.docker.com/r/nvidia/cuda/tags

chmod +x scipy-cpu/*.sh
chmod +x scipy-cpu/fix-permissions
chmod +x scipy-gpu/*.sh
chmod +x scipy-gpu/fix-permissions


#date=$(date '+%Y%m%d-%H%M%S')
date=$(date '+%Y%m%d')
private_registry=172.20.137.125:5000/

tag_and_push_image() {
	docker push $1

	docker tag $1 $1-$date
	docker push $1-$date

	docker tag $1 $private_registry$1
	docker push $private_registry$1
}


# cpu notebook
for py in 3.7 3.8 3.9 3.10
do
	base_image_name=scipy-cpu
	base_image_tag=zhushaojun/$base_image_name:py$py
	docker build --build-arg PYTHON_VERSION=$py --tag $base_image_tag ./$base_image_name
	# tag_and_push_image $base_image_tag

	for image_name in pycaret auto-sklearn
	do
		tagname=zhushaojun/$image_name:py$py
		docker build --build-arg BASE_CONTAINER=$base_image_tag --tag $tagname ./$image_name
		tag_and_push_image $tagname
	done
done


# gpu notebook
for py in 3.7 3.8 3.9 3.10
do
	base_image_name=scipy-gpu
	base_image_tag=zhushaojun/$base_image_name:py$py
	docker build --build-arg PYTHON_VERSION=$py --tag $base_image_tag ./$base_image_name
	tag_and_push_image $base_image_tag

	for image_name in mxnet pytorch tensorflow
	do
		tagname=zhushaojun/$image_name:py$py
		docker build --build-arg BASE_CONTAINER=$base_image_tag --tag $tagname ./$image_name
		tag_and_push_image $tagname
	done
done
