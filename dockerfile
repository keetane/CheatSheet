# M1 MacでUbuntuコンテナを作る時の注意
# https://qiita.com/silloi/items/739699337b9bf4883b3e
FROM --platform=linux/amd64 ubuntu:22.04

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
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y build-essential default-jre git

# prompt setting
# https://zenn.dev/melos/articles/043fc03789603c
WORKDIR /root
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
RUN wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
COPY ./bash_config /root

RUN cat /root/bash_config >> /root/.bashrc

#install miniconda3
WORKDIR /opt
# download miniconda package and install miniconda
# archive -> https://docs.conda.io/en/latest/miniconda.html
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /opt/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda3
RUN rm -f Miniconda3-latest-Linux-x86_64.sh
# set path
ENV PATH /opt/miniconda3/bin:$PATH
RUN conda config --add channels conda-forge
RUN conda config --remove channels defaults

# create environment
RUN conda create -n chem -y python=3.9 rdkit pubchempy scikit-learn 


# OpenBabel3
RUN apt-get update
RUN apt install openbabel libopenbabel-dev -y

WORKDIR /work

# sbddというdocker imageをbuild
# docker build -t chem . 

# 最初からbuildするなら--no-cache
# docker build -t chem . --no-cache

# ubuntuというcontainerをsbddというimageからcreateしてbashでrun
# docker run -it -v ~/Documents/Linux:/work --name chem chem bash

# dockerfileのキャッシュを確認
# docker system df
# dockerfileのキャッシュを削除
# docker builder prune
