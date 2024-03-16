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
WORKDIR ~
RUN git clone https://github.com/openbabel/openbabel.git
WORKDIR openbabel
RUN mkdir build
WORKDIR build
RUN cmake -DWITH_MAEPARSER=OFF -DWITH_COORDGEN=OFF -DPYTHON_BINDINGS=ON -DRUN_SWIG=ON ..
RUN make
RUN make install

WORKDIR /work

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
