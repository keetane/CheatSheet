# M1 MacでUbuntuコンテナを作る時の注意
# https://qiita.com/silloi/items/739699337b9bf4883b3e
FROM --platform=linux/amd64 ubuntu:latest
# update
RUN apt-get -y update && apt-get install -y \
libsm6 \
libxext6 \
libxrender-dev \
libglib2.0-0 \
sudo \
wget \
unzip \
vim

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
RUN conda create -n pymol python=3.7

# install conda package
SHELL ["conda", "run", "-n", "pymol", "/bin/bash", "-c"]
# https://qiita.com/kimisyo/items/66db9c9db94751b8572b

RUN command conda config --append channels conda-forge
RUN conda install -c rdkit -c conda-forge rdkit --override-channels
RUN conda install -c conda-forge pymol-open-source
RUN conda install plotly
RUN conda install -c conda-forge nodejs jupyterlab

RUN sudo apt-get install make
RUN sudo apt-get install build-essential
RUN sudo apt install openjdk-11-jdk


# WORKDIR /
# RUN mkdir /work
# WORKDIR /



# # execute jupyterlab as a default command
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]


# sbddというdocker imageをbuild
# docker build -t sbdd . 

# ubuntuというcontainerをsbddというimageからcreateしてbashでrun
# docker run -it -v ~/Documents/Linux:/work --name ubuntu sbdd bash