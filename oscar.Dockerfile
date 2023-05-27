# registry.cn-hongkong.aliyuncs.com/wenzhiquan/oscar_env:1.0

FROM nvidia/cuda:10.0-devel-ubuntu18.04

# install basics
RUN apt-get update -y \
 && apt-get -y install apt-utils git curl ca-certificates bzip2 cmake tree htop bmon iotop g++ \
 && apt-get -y install libglib2.0-0 libsm6 libxext6 libxrender-dev libyaml-dev vim wget htop tmux

# Install Miniconda
RUN curl -so /miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && chmod +x /miniconda.sh \
 && /miniconda.sh -b -p /miniconda \
 && rm /miniconda.sh

ENV PATH=/miniconda/bin:$PATH

# Create a Python 3.7 environment
RUN /miniconda/bin/conda install -y conda-build \
 && /miniconda/bin/conda create -y --name py37 python=3.7 \
 && /miniconda/bin/conda clean -ya

ENV CONDA_DEFAULT_ENV=py37
ENV CONDA_PREFIX=/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

RUN conda install -y ipython nltk joblib jupyter pandas scipy
RUN pip install tqdm matplotlib requests scikit-image anytree regex boto3
RUN pip --no-cache-dir install --force-reinstall -I pyyaml

# Install latest PyTorch 1.2.0
ARG CUDA
RUN pip install torch==1.2.0 torchvision==0.4.0 \
 && conda clean -ya

RUN git clone https://github.com/NVIDIA/apex.git \
 && cd apex \
 && python setup.py install --cuda_ext --cpp_ext
