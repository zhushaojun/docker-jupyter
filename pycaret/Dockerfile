# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG ROOT_CONTAINER
FROM ${ROOT_CONTAINER}

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pycaret
RUN mamba install --yes --quiet -c conda-forge \
    shap pycaret && \
    pip install daal==2021.3.0 daal4py pycaret[full]  --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
