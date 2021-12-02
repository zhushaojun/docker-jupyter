# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER
FROM ${BASE_CONTAINER}

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Tensorflow
RUN mamba install --yes \
    'tensorflow<2.6' && \
    mamba clean --all -f -y && \
    pip install autokeras  --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
