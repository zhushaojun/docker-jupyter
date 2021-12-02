# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM $BASE_CONTAINER

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install mxnet and autogluon
RUN mamba install --quiet --yes \
    'cudatoolkit=10.2' \
    mamba clean --all -f -y && \
    pip install mxnet-cu102==1.7.0 autogluon --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
