# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pycaret
RUN pip install pycaret[full]  --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
