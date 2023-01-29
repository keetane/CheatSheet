FROM continuumio/miniconda3

# update
RUN apt-get -y update && apt-get install -y \
libsm6 \
libxext6 \
libxrender-dev \
libglib2.0-0 \
sudo \
wget \
vim

RUN sudo apt-get install make
RUN sudo apt-get install build-essential
RUN sudo apt install openjdk-11-jdk
# dpkg -L `package name` で格納先を確認


# conda create
RUN conda create -n pymol python=3.7

# set path
ENV PATH /opt/miniconda3/bin:$PATH


# install conda package
SHELL ["conda", "run", "-n", "pymol", "/bin/bash", "-c"]
# https://qiita.com/kimisyo/items/66db9c9db94751b8572b

RUN command conda config --append channels conda-forge
RUN conda install -c rdkit -c conda-forge rdkit --override-channels
RUN conda install -c conda-forge pymol-open-source
# https://qiita.com/kojix2/items/3c57a50fc29ac5361952
RUN conda install plotly
RUN conda install -c conda-forge nodejs jupyterlab

# install pip package
RUN pip3 install --upgrade pip

WORKDIR /
RUN mkdir /work

# # execute jupyterlab as a default command
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]




# docker build -t x . --no-cache
# docker run -it --name test k_linux bash
# docker run -v ~/Documents/Linux:/work --name test x
