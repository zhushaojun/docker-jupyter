# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM $BASE_CONTAINER


# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install pytorch
RUN mamba install --quiet --yes -c pytorch \
    'pytorch' \
    'torchvision' \
    'torchaudio' \
    'torchtext' \
    'cudatoolkit=10.2' && \
    mamba clean --all -f -y && \
    pip install pytorch-lightning  --no-cache-dir && \
    rm -fr ~/.cache && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
