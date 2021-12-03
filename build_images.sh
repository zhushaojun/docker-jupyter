#!/bin/bash

py_versions=(3.7 3.8 3.9)
# cuda_version=(11.4.2-cudnn8-runtime-ubuntu20.04
# https://hub.docker.com/r/nvidia/cuda/tags

chmod +x scipy/*.sh
chmod +x scipy/fix-permissions

docker system prune -y

#date=$(date '+%Y%m%d-%H%M%S')
date=$(date '+%Y%m%d')
# gpu notebook
for py in 3.7 3.8
do
	base_image_name=scipy-gpu
	base_image_tag=zhushaojun/$base_image_name:$py
	docker build --build-arg PYTHON_VERSION=$py --tag $base_image_tag ./$base_image_name
	docker push $base_image_tag
	tag_with_date=$base_image_tag-$date
	docker tag $base_image_tag $tag_with_date
	docker push $tag_with_date

	for image_name in mxnet pytorch tensorflow
	do
		tagname=zhushaojun/$image_name:$py
		docker build --build-arg BASE_CONTAINER=$base_image_tag --tag $tagname ./$image_name
		docker push $tagname
		tag_with_date=$tagname-$date
		docker tag $tagname $tag_with_date
		docker push $tag_with_date
	done
done

# cpu notebook
for py in 3.7 3.8
do
	base_image_name=scipy-cpu
	base_image_tag=zhushaojun/$base_image_name:$py
	docker build --build-arg PYTHON_VERSION=$py --tag $base_image_tag ./$base_image_name
	docker push $base_image_tag
	tag_with_date=$base_image_tag-$date
	docker tag $base_image_tag $tag_with_date
	docker push $tag_with_date

	for image_name in auto-sklearn pycaret
	do
		tagname=zhushaojun/$image_name:$py
		docker build --build-arg BASE_CONTAINER=$base_image_tag --tag $tagname ./$image_name
		docker push $tagname
		tag_with_date=$tagname-$date
		docker tag $tagname $tag_with_date
		docker push $tag_with_date
	done
done
