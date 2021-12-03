# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER
FROM ${BASE_CONTAINER}

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install auto-sklearn
RUN mamba install --quiet --yes -c conda-forge \
    'gcc_linux-64' \
    'swig' \
    'auto-sklearn' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
