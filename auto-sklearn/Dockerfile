# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG ROOT_CONTAINER
FROM ${ROOT_CONTAINER}

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install auto-sklearn
RUN mamba install --yes --quiet -c conda-forge \
    gxx_linux-64 gcc_linux-64 swig \
    'auto-sklearn' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
