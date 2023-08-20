# Conda Command

## 構築環境
- pymol
  > conda create -n pymol -c conda-forge python=3.10 pymol-open-source

- openmm (with PyMOL)
  > conda create -n openmm -c conda-forge python=3.10 openmm openmm-setup pymol-open-source

- openmm (with cudatoolkit, without PyMOL)
  > conda create -n openmm python=3.10 openmm openmm-setup cudatoolkit=11.2

- chemoinfomatics [ref](https://datachemeng.com/post-4358/)
  > conda create -n ci -c conda-forge -y python=3.10  numpy pandas scipy matplotlib seaborn scikit-learn boruta_py lightgbm xgboost deap rdkit jupyterlab spyder

- bioinfomatics
    > conda create -n bi -c conda-forge -y python=3.10 pandas pymol-open-source BioPython 



## conda環境の一覧
> conda info -e

## Channelの追加や削除
- conda-forge channelの追加
  > conda config --append channels conda-forge

- defaults channelを削除
  > conda config --remove channels defaults

## パッケージ管理
- 現在のconda環境のパッケージ一覧表示
  > conda list
- 指定したconda環境のパッケージ一覧表示
  > conda list -n py38

- パッケージの検索
  > conda search tensorflow

- パッケージインストール
  - インストール
  > conda install tensorflow
  - バージョン指定してインストール
  > conda install tensorflow=1.15

- パッケージの更新
  - パッケージを最新に
  > conda update tensorflow
  - すべてのパッケージを最新に
  > conda update --all

- パッケージの削除
  > conda remove tensorflow

- パッケージリストを出力
  > conda list --export > package-list.txt


## 仮想環境作成
-  pythonバージョンを指定して作成
> conda create --name py38 python=3.8  
> conda create -n py38 python=3.8

- 仮想環境をコピーして作成  
例：baseをコピーしてpy38を作る

> conda create -n py38 --clone base

- 環境再現のためのリストから環境を再構築
> conda create -n py38 --file package-list.txt

## conda環境
- 有効化
  > conda activate py38

- conda環境の出力
  > conda env export > env_name.yml

- ymlファイルから環境を再構築
    > conda env create -n env_name2 -f env_name.yml

- conda環境の終了
    > conda deactivate

- 仮想環境の削除
    > conda remove -n py38 --all

