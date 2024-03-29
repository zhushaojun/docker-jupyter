#!/bin/bash

# cuda_version=(11.4.2-cudnn8-runtime-ubuntu20.04
# https://hub.docker.com/r/nvidia/cuda/tags

#构建以前清理容器和镜像
docker container prune -f
docker image prune -a -f

chmod +x scipy/*.sh

date=$(date '+%Y%m%d')
private_registry=172.20.137.125:5000/

tag_and_push_image() {
	echo -e "\033[42;37m Pushing $1 \033[0m"
	docker push $1

	docker tag $1 $1-$date
	echo -e "\033[42;37m Pushing $1-$date \033[0m"
	docker push $1-$date

	echo -e "\033[42;37m Pushing $private_registry$1 \033[0m"
	docker tag $1 $private_registry$1
	docker push $private_registry$1
}

# https://hub.docker.com/_/ubuntu?tab=tags&page=1
cpu_base=ubuntu:20.04
# https://hub.docker.com/r/nvidia/cuda/tags
gpu_base=nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

build_and_push() {
	echo -e "\033[42;37m Building $3 \033[0m"
	docker build --build-arg PYTHON_VERSION=$1 --build-arg ROOT_CONTAINER=$2 --tag $3 ./$4
	tag_and_push_image $3
}

# gpu notebook
for py in 3.8 3.9 3.10
do
	base_image_tag=zhushaojun/scipy:py$py-gpu
	build_and_push $py $gpu_base $base_image_tag scipy

	for image_name in mxnet pytorch tensorflow
	do
		build_and_push $py $base_image_tag zhushaojun/$image_name:py$py-gpu $image_name
	done
done


# cpu notebook
for py in 3.8 3.9 3.10
do
	base_image_tag=zhushaojun/scipy:py$py-cpu
	build_and_push $py $cpu_base $base_image_tag scipy

	for image_name in pycaret auto-sklearn
	do
		build_and_push $py $base_image_tag zhushaojun/$image_name:py$py-cpu $image_name
	done
done


# push all images again
for image in mxnet pytorch tensorflow pycaret auto-sklearn
do
	docker image push --all-tags zhushaojun/$image
done
