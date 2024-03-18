# ぼっちGit
### 作業の流れ  
1. [subブランチを切る](#subブランチを切る)
2. [前回コミットからの差分確認](#前回コミットからの差分確認)
3. [更新の切りのいいところでstaging](#更新の切りのいいところでstaging)
4. [前回コミットからの差分確認](#前回コミットからの差分確認)
5. [コミット(記録)する](#コミット(記録)する)
6. [mainブランチとの差分を確認](#mainブランチとの差分を確認)
7. [mainブランチとmerge](#mainブランチとmerge)
8. 2に戻る

## subブランチを切る [Top](#作業の流れ)
作業を開始する前にsubブランチを切ることで、mainのファイルとは別の履歴として残すことができる。  
まずはbranchを確認する。
```zsh
git branch
# * main
#   test
```
必要のないものは削除できる。
```zsh
git branch -d `target branch`
```
branchを移動する。
```zsh
git checkout test
git branch
#   main
# * test
```
branchを新規に作成して移動する場合はcheckoutに`-b`オプション
```zsh
git checkout -b sub
git branch
#   main
#   test
# * sub
```

## 前回コミットからの差分確認 [Top](#作業の流れ)
`git status`で前回コミットからの変更点やstaging状況を確認できる。   
```zsh
git status
# stagingされていない更新状況は下記のイメージ
# On branch sub
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#         git.md

# nothing added to commit but untracked files present (use "git add" to track)
```
`git diff`でbranchの変更点や差分を確認できる。
```zsh
git diff
# 前回コミットと変更なければ出力されない
```


## 更新の切りのいいところでstaging [Top](#作業の流れ)
