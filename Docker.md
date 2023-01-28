![docker図解](https://penpen-dev.com/blog/wp-content/uploads/hsthbrt.png)  
https://penpen-dev.com/blog/docker-command/

### Docker超入門
https://datawokagaku.com/category/%e8%ac%9b%e5%ba%a7%e4%b8%80%e8%a6%a7/docker%e8%b6%85%e5%85%a5%e9%96%80/

### ぷんたむの悟りの書
https://punhundon-lifeshift.com/dockerfile

### miniconda + conda-forgeで開発環境を揃える
https://qiita.com/kimisyo/items/66db9c9db94751b8572b    


# docker hubからimageをpull
```terminal
docker pull `image:ver`
```

# pullしたimageを参照
```
docker images

# REPOSITORY                      TAG       IMAGE ID       CREATED        SIZE
# ubuntu                          latest    4c2c87c6c36e   7 weeks ago    69.2MB
# python                          latest    9dda5bedc1c7   3 months ago   868MB
```

# imageからコンテナを作ってrun
### enterはしない
### imageを持ってない場合はhubからpullしてくる

```
docker run `image_name` 
docker run --name `container_name` `image_name`  # --name ``でcontainer nameを指定できる
docker run --name test hello-world

# Hello from Docker!
# This message shows that your installation appears to be working correctly.
# ...
```

# containerのリストを表示
```
docker ps # upのものだけ
docker ps -a # 全て表示

# CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS                      PORTS     NAMES
# 498900d17e03   hello-world                    "/hello"                 2 minutes ago   Exited (0) 2 minutes ago              test
# cdf417f58458   continuumio/anaconda3:latest   "/bin/bash"              3 months ago   Exited (137) 20 hours ago             anaconda3

# runしただけではcontainer statusはexited
```

# containerを起動する
```
docker restart `container_name`

docker restart test
# test

docker ps -a
CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS                      PORTS     NAMES
498900d17e03   hello-world                    "/hello"                 7 minutes ago   Exited (0) 48 seconds ago             test
cdf417f58458   continuumio/anaconda3:latest   "/bin/bash"              3 months ago    Exited (137) 20 hours ago             anaconda3

# hello-worldにはOSとbashが入ってないので起動(=up)にならない
```

```
docker restart anaconda3
# anaconda3

docker ps # status == up のcontainerを表示

CONTAINER ID   IMAGE                          COMMAND       CREATED        STATUS         PORTS     NAMES
cdf417f58458   continuumio/anaconda3:latest   "/bin/bash"   3 months ago   Up 5 seconds             anaconda3
```

# 起動中のcontainerに入って新しいbashで作業する (execute)
```
docker exec -it `container_name` bash
# root@random_text:/#      # containerのbash promptが返ってくる
```

### docker attachとの違いについて
https://qiita.com/RyoMa_0923/items/9b5d2c4a97205692a560  
attach : container内の既に起動しているbashを使う  
exec -it : 新たにbashを立ち上げる


# 起動したままcontainerから抜ける (detach)
```
ctrl+p ctrl+q
```
### VS codeではVS codeのショートカットが起動してしまうので変更する必要がある
https://qiita.com/Statham/items/c204e85067ea4dca2724  

```
docker ps

# CONTAINER ID   IMAGE                          COMMAND       CREATED        STATUS          PORTS     NAMES
# cdf417f58458   continuumio/anaconda3:latest   "/bin/bash"   3 months ago   Up 10 minutes             anaconda3
```

# 起動中のcontainerのbashに入って作業する
```
docker attach `container_name`
# root@random_text:/#      # container/bashのpromptが返ってくる
```

# containerを停止して脱出する
```
root@random_text:/# exit

docker ps -a
STATUS          PORTS     NAMES
# cdf417f58458   continuumio/anaconda3:latest   "/bin/bash"   3 months ago   Exited 10 seconds             anaconda3

```


# imageからcontainerを作ってbashで作業する
```
docker run -it `image_name` bash # interact terminal

# root@random_id:/#     # containerのbash promptが返ってくる

root@random_id:/# exit  # containerを停止してexitする

# directory$            # hostのterminal promptに戻る
```

# imageからcontainerにlocal volumeをマウントしてbashで作業する
```

```

# imageからcontainerにlocal volumeをマウントしてjupyterのポートを割り当ててbashで作業する
```

```

# dockerfileからbuild
```
cd `working directory`
docker build -t `image_name` .
```

# コンテナをimageにcommit
```
docker commit `container_name` `image_name:ver`

docker images

# REPOSITORY                      TAG       IMAGE ID       CREATED         SIZE
# ubuntu                          latest    4c2c87c6c36e   7 weeks ago     69.2MB
# python                          latest    9dda5bedc1c7   3 months ago    868MB
# continuumio/anaconda3           latest    40d5cbe3a8cd   7 months ago    2.69GB

docker commit anaconda3 continuumio/anaconda3
# sha256:1b5cfa5999b6dceb07ddd5ebea6c7c24ec98d61a783fa719443a5adb2a4016b9

docker images

# REPOSITORY                      TAG       IMAGE ID       CREATED         SIZE
# continuumio/anaconda3           latest    1b5cfa5999b6   4 seconds ago   3.26GB
# ubuntu                          latest    4c2c87c6c36e   7 weeks ago     69.2MB
# python                          latest    9dda5bedc1c7   3 months ago    868MB
# continuumio/anaconda3           <none>    40d5cbe3a8cd   7 months ago    2.69GB
```

# docker imageを削除
```
docker rmi `image_name`

docker rmi continuumio/anaconda3
docker images

# REPOSITORY                      TAG       IMAGE ID       CREATED         SIZE
# ubuntu                          latest    4c2c87c6c36e   7 weeks ago     69.2MB
# python                          latest    9dda5bedc1c7   3 months ago    868MB
# continuumio/anaconda3           <none>    40d5cbe3a8cd   7 months ago    2.69GB

# 指定しないとlatestが消えるっぽい
# latestがないimageは`:ver`でtagを指定しないと消えない
# containerで使用中だとreferenceになっているため削除できない
```

# docker containerを削除
```
docker rm `container_name` # or `container_id`
```


# docker hubにログイン
```
docker login
```

# imageをdocker hubのrepoにpush
```
docker push `user_id/image_name:ver`
```

# dockerfileからbuildする
```

```