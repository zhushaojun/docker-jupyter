# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG ROOT_CONTAINER
FROM ${ROOT_CONTAINER}

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install mxnet and autogluon
RUN mamba install --yes -c pytorch \
    'pytorch' \
    'torchvision' \
    'cudatoolkit=10.2' && \
    mamba clean --all -f -y && \
    pip install mxnet-cu102==1.7.0 --no-cache-dir && \
    pip install autogluon --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
