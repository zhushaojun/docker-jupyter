# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER
FROM ${BASE_CONTAINER}


# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pytorch
RUN mamba install --quiet --yes -c pytorch -c fastchan \
    'pytorch' \
    'torchvision' \
    'torchaudio' \
    'torchtext' \
    'fastai' \
    'cudatoolkit=10.2' && \
    mamba clean --all -f -y && \
    pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
    pip install pytorch-lightning  --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
