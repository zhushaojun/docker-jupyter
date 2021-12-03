# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER
FROM ${BASE_CONTAINER}

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pycaret
RUN mamba install --yes -c conda-forge \
    shap && \
    pip install daal4py pycaret[full]  --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
