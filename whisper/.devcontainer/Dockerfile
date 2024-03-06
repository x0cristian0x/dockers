FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ENV PYTHON_VERSION=3.10

RUN apt-get -qq update \
    && apt-get -qq install --no-install-recommends \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-venv \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s -f /usr/bin/python${PYTHON_VERSION} /usr/bin/python3 && \
    ln -s -f /usr/bin/python${PYTHON_VERSION} /usr/bin/python && \
    ln -s -f /usr/bin/pip3 /usr/bin/pip

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Install whisper
RUN apt-get -y update && apt-get install -y git 
RUN pip3 install git+https://github.com/openai/whisper.git 
RUN pip3 install --upgrade --no-deps --force-reinstall git+https://github.com/openai/whisper.git
RUN pip3 install ipykernel setuptools-rust

COPY script_model.py .
RUN python3 script_model.py

RUN rm /cuda-keyring_1.0-1_all.deb /script_model.py
