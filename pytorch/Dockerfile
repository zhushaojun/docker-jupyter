# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG ROOT_CONTAINER
FROM ${ROOT_CONTAINER}


# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pytorch
RUN pip install torch torchvision torchaudio torchtext fastai pytorch-lightning --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
