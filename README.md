# docker-jupyter


``` bash
# 指定GPU
docker run -P --pull=always --gpus '"device=1,2"' 172.20.137.125:5000/zhushaojun/tensorflow:py3.8-gpu

# cpu
docker run -P --pull=always 172.20.137.125:5000/zhushaojun/scipy:py3.7-cpu
```
