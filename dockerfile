# M1 MacでUbuntuコンテナを作る時の注意
# https://qiita.com/silloi/items/739699337b9bf4883b3e
FROM --platform=linux/amd64 ubuntu:20.04

# update
RUN apt-get -y update && apt-get install -y \
libsm6 \
libxext6 \
libxrender-dev \
libglib2.0-0 \
sudo \
wget \
curl \
unzip \
vim 
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y build-essential 


# p2rank installation
RUN apt install -y default-jre
RUN mkdir -p /usr/local/apps
WORKDIR /usr/local/apps
RUN curl -L -O https://github.com/rdk/p2rank/releases/download/2.4/p2rank_2.4.tar.gz
RUN tar -xvf ./p2rank_2.4.tar.gz

# 不要なファイルの削除
RUN rm -f ./p2rank_2.4.tar.gz

# P2Rankのlogファイルの出力先を変更
RUN sed -i -e 's|$INSTALL_DIR|$HOME/.p2rank|g' ./p2rank_2.4/prank

# set a path
ENV PATH $PATH:/usr/local/apps/p2rank_2.4




#install miniconda3
WORKDIR /opt
# download miniconda package and install miniconda
# archive -> https://docs.conda.io/en/latest/miniconda.html
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /opt/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
RUN rm -f Miniconda3-latest-Linux-x86_64.sh
# set path
ENV PATH /opt/miniconda3/bin:$PATH

# conda create
RUN conda create -n sbdd python=3.7

# install conda package
SHELL ["conda", "run", "-n", "pymol", "/bin/bash", "-c"]
# https://qiita.com/kimisyo/items/66db9c9db94751b8572b

RUN command conda config --append channels conda-forge
RUN conda install pip
RUN pip install lightdock
RUN conda install -c conda-forge rdkit -y
# RUN conda install -c conda-forge pymol-open-source -y
# RUN conda install -c conda-forge nodejs jupyterlab


RUN conda init
WORKDIR /work

# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--ServerApp.token=''"]

# かめさんのdocker image_name
# datascientistus/ds-python-env

# sbddというdocker imageをbuild
# docker build -t sbdd . 

# 最初からbuildするなら--no-cache
# docker build -t sbdd . --no-cache

# ubuntuというcontainerをsbddというimageからcreateしてbashでrun
# docker run -it -v ~/Documents/Linux:/work --name sbdd sbdd bash

# dockerfileのキャッシュを確認
# docker system df
# dockerfileのキャッシュを削除
# docker builder prune
