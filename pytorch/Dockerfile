# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG ROOT_CONTAINER
FROM ${ROOT_CONTAINER}


# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pytorch
RUN mamba install  --yes -c pytorch -c fastai \
    'pytorch' \
    'torchvision' \
    'torchaudio' \
    'torchtext' \
    'fastai' \
    'cudatoolkit=10.2' && \
    mamba clean --all -f -y && \
    pip install pytorch-lightning  --no-cache-dir && \
    rm -fr ~/.cache/pip && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
