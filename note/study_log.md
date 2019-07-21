# study log start now

## never too young to study

### 2019-07-16

    《跟老男孩学Linux运维：shell编程实战》
    1） while 循环   usleep 1000 #睡眠1000微秒
    2） 脚本开发规范：尽量模块化和变量化
    3） echo -e "\E[5;31m红色字oldboy\E[0m"     #终端闪烁显示红色字体的"红色字oldboy"
    4） man console_codes   #查阅更多相关终端背景色和字体色的资料
    5） Linux常用的重要信号及说明：HUP(1)   INT(2)    QUIT(3)   ABRT(6)     ALARM(14)   TERM(15)    TSTP(20)  
    6） stty -a     #列出中断信号与键盘的对应信息
    7） 使用 expect 自动交互软件，主要关键词： #!/usr/bin/expect ，spawn ，exp_send , exp_continue , exp eof
    8） dos2unix 转换 dos 和 unix 编码格式
    9） 合格的运维人员必会的脚本列表

### 2019-07-17

    《跟老男孩学Linux运维：shell编程实战》
    1）产生随机数的方法：
        openssl rand -base 40   #产生40位随机数，echo "$rand"   #本身只能提供的随机数范围为0~32767
        echo "awsl$RANDOM"|md5sum|cut -c 2-10   #通过加密截取的方法获得8位随机数
    2） #相关配置文件在~/.gitconfig 文件中(详细内容补充在 line99)
        github 初次使用的配置流程:
        git config --global user.name "way-ww"
        git config --global user.mail "875749864@outlook.com"
        git config --global color.ui auto
        ssh-keygen -t rsa -C "875749864@outlook.com"    #在 ~/.ssh/id_rsa 文件夹中生成私钥（文件名为id_rsa）和公钥（文件名为id_rsa.pub）
        在GitHub中添加SSH公钥
        用手中的私钥与GitHub中的公钥配对使用：ssh -T git@github.com
        克隆仓库到本地: git clone git@github.com:way-ww/first_github
        git status 查看当前git状态
        git add 添加修改到暂存区
        git commit -m "commit简易说明" 或者使用 git commit 命令详细说明(第一行记录提交更改的内容，第二行空行，第三行记录更改的原因和详细内容)
        git log 查看提交日志
        git push 推送commit到远程仓库（GitHub）

    3） 上面的是现在GitHub上创建仓库然后clone到本地的流程，以下则是在本地开始创建仓库并最终推送到GitHub上的流程
        mkdir second_github
        cd second_github
        git init    #产生.git目录，此目录的内容也叫做仓库的工作树，文件的编辑等操作在工作树中进行然后记录到仓库中，可用来管理文件的历史快照和文件恢复。
        vim README.md
        git add README.md
        git commit -m " "
        git log README.md   #查看指定文件相关的日志
        git log -p  #查看提交带来的改动，文件前后的差别变化
        git log -p README.md    #也可以查看指定文件的前后差异
        git diff    #查看工作树，暂存区及最新提交的差异
        好习惯：在git commit之前先使用 git diff HEAD 查看本次提交与上次提交之间的差别，待确认完毕后再提交。提交之后再使用git log 确保以正确提交内容
        git branch  #显示分支一览表，左侧有 * 的为当前所在分支
        git checkout -b feature-A   #创建并切换至分支feature-A
        git checkout master     #切换到master，git checkout 用来切换分支
        git merge:
        git checkout master     #首先切换到主分支准备合并分支feature-A
        git merge --no-ff feature-A     #自动打开编辑器用于记录合并提交信息，默认信息中会包含从featur-A合并过来的相关内容，保存退出即可完成合并
        git log --graph     #以图表形式查看分支和commit信息，注意是从下往上看的
        git reset --hard 哈希值    #回溯历史版本，哈希值从git log可得，本例中是回溯到创建feature-A分支前的版本,哈希值只需要输入前7位即可
        本例中是回溯到创建feature-A分支前的版本再创建分支fix-b再推进历史到feature-A合并后的版本，然后合并分支fix-b并解决冲突的过程
        git log 只能查看当前版本状态为终点的历史日志，所以这里要使用git reflog查看当前仓库的历史日志，从而找到回溯历史前的哈希值
        git reflog  #查找到回溯历史前的哈希值
        git checkout master     #注意要切换到主分支再恢复或者回溯，不要弄错了，因为最终还是要吧fix-b合并到合并feature-A合并后的版本
        git reset --hard 哈希值     #恢复到回溯历史前的版本状态
        git merge --no-ff fix-b     #合并fix-b到master，注意此时会提示出现冲突，打开冲突的文件（本例中为vim README.md）解决冲突，然后重新添加到暂存区提交。
        git commit --amend  #修改上一次提交的信息
        git rebase -i   #压缩历史，例如发现一些拼写错误，我们需要再一次提交进行修正，但事实上我们不希望这类提交出现，这会使我们的提交日志大幅增加，不利于快速定位有用的信
        息，所以我们需要将这类小的提交压缩到前一次的提交中，这样我们就能避免提交日志的数量增加。
        #本例中新建分支c并提交含有typo的README.md提交成功后再申请一个提交修改typo错误，然后在使用git rebase压缩到前一次的提交中去。
        git checkout -b feature-c   #创建新的分支c
        vim README.md
        git commit -am ""   #第一次提交分支c的README.md
        vim README.md       #修正第一次提交中的错误
        git commit -am ""   #提交修正好的README.md
        git rebase -i HEAD~2    #使用git rebase 选中当前分支中包含HEAD（最新提价）在内的俩次历史记录，并在编辑器中打开。
        在编辑器中将修正提交错误的那个提交的那行左侧的pick替换成fixup保存退出即可
        推送远程仓库
        GitHub上创建新的同名仓库，注意一定不要勾选初始化仓库
        git remote add origin git@github.com:way-ww/second_github       #添加远程仓库，并将远程仓库的名称设置为origin（标识符）
        git push -u origin master   #推送至远程仓库的master分支，-u参数将origin仓库的master分支作为本地仓库当前分支的upstream（上游），方便以后git pull 获取远程内容
        git checkout -b feature-d   #演示推送至远程仓库的d分支
        git push -u origin feature-d    #将本地当前仓库内容同名push至远程仓库，此时可以在GitHub中看到新建的分支feature-d
        > 删除本地git仓库的方法
        > rm .git 即可


### 2019-07-18

       《GitHub入门与实践》
       发送pull request 的规范
       在 GitHub 上 fork 仓库
       git clone 到本地进行修改或者也可以直接在网站上进行修改
       clone 到本地后先创建特性分支用作发送pr
       git commit -am "说明原因"    #在本地正常提交
       git push origin 特性分支
       打开 GitHub 确认是否完成推送
       在 GitHub 上发送 pr
       注意事项：
       当前所处分支情况
       工作前需要与远程仓库同步
       git push 时注意当前所在分支状态
       在commit 之前先使用git diff 查看差异后在提交，提交之后本地使用git log 查看日志是否完成提交，远程仓库在web 上查看差异和 pr
       <完>
       git add  .        # 将当前目录下的所有文件变更(包括新文件)放入暂存区
       git add ­-u       # 将当前目录下被版本库跟踪的所有文件变更(不包括新文件)放入暂存区
       git add ­-A       # 将当前目录下所有文件变更(包括新文件)放入暂存区,并查找重命名情况
       git add ­-i       # 使用交互式界面选择需要添加的文件


### 2019-07-19

《Git 手册》
        git config 配置文件所在位置：
        git config --system         /etc/gitconfig             系统
        git config --global         ~/.gitconfig               当前用户
        git config                  .git/config                当前版本库
        git reset --filename        #git add 的反向操作
        git blame :
        查看这个文件的每行最早是在什么版本、由谁引入的,以便定位引起 bug 的版本和开发者
        git blame <filename>
        只查看某几行:( 6,10 中间不能有空格)
        git blame ­L 6,10 README
        git blame ­L 6,+5 README
       《 Git pro2 》
        感受到了git版本控制的强大，切换至任一文件夹，使用git init即可使用git来托管，同一文件在不同分支内容不同，使用文件管理器打开显示的内容为退出时所在分支的内容
        gitignore **********which made me mad !!!!! I take out of serval hours on to konw this issue!!!
        关于位置：
        .gitignore文件可以在需要忽略的文件同目录下创建并在其中添加需要忽略跟踪的文件名，也可以在仓库的根目录下创建，根目录下的.gitignore文件中要忽略飞当前目录下内容要补全文件名和路径（相对路径即可）并注意格式。
        一下为一个示例：
        # no .a files
        *.a
        # but do track lib.a, even though you're ignoring .a files above
        !lib.a
        # only ignore the TODO file in the current directory, not subdir/TODO
        /TODO
        # ignore all files in the build/ directory
        build/
        # ignore doc/notes.txt, but not doc/server/arch.txt
        doc/*.txt
        # ignore all .pdf files in the doc/ directory
        doc/**/*.pdf
        git rm gitest       #将文件从git管理中移除，提交后本地文件gitest也将会被移除
        git rm --cached gitest      #将文件从git管理中移除，且本地文件gitest任然保留，但是会显示未跟踪，所以还是要添加.gitignore文件并提交.gitignore文件。
        忽略跟踪文件时注意事项：
        已经使用git进行跟踪管理的文件需要先将其git rm --cached 移除管理后添加到.gitignore文件中才是正确的忽略步骤
        若文件没有被从git跟踪列表中清除.gitignore文件即使添加了忽略规则也不会生效 ！！！！！我就是在这里浪费了几个小时怀疑人生的!!!!!!!!
        正确的使用gitignore步骤：
        1)需要忽略的文件还没有生成或创建
        提前编辑好.gitignore文件并提交，这样在需要忽略的文件被创建或者产生的时候就能正确自动的忽略了
        例如C语言，pytho，Java等编译过程中产生的临时文件显然是不需要进行跟踪记录的，我们就可以提前添加好.gitignore文件规则，在他们生成的时候自动的忽略掉。
        GitHub上有相当完善的.gitignore文件模板值得借鉴  https://github.com/github/gitignore
        2）需要忽略的文件已经在跟踪列表中
        已经存在与跟踪列表中的文件即使添加到.gitignore文件中也不会被忽略掉，需要先从git管理中删除才能进一步忽略掉
        git rm --cached xxx     #从跟踪列表中删除，并且原文件任然保存在原来位置。执行完这一步之后，xxx文件会显示未被跟踪，下一步就可以将其添加到忽略文件中
        vim .gitignore          #将xxx 添加到.gitignore文件中并提交，此后xxx 文件将不会再被跟踪也不会在git status 中显示 xxx untracted 等信息


### 2019-07-20

        《Git pro2》
        移动文件：
        git 不能够显式跟踪文件移动操作，若在git中重命名了某个文件，git不会理解这是一个改名操作，而是认为删除了一个文件
        使用git mv file1 file2 完成更改文件名的操作
        git mv 相当与一次执行三个命令
        mv file1 file2
        git rm file1
        git add file2
        以上命令同样可以完成改名操作，只是复杂了些
        git log --stat  #显示提交日志的同时显示每次提交文件的变化情况
        撤销：
        1)提交完之后发现有文件本应该修改并且一并提交的被遗漏
        修改文件，且距离上次遗漏的提交没有更新的提交，即：上次遗漏文件的提交之后没有作其他的提交
        git add fogotenfile
        git commit --amend      #此时会打开编辑器并显示上次提交的内容修改保存退出即可
        2）仅是要修改或者完善上次提交的提交信息
        git commit --amend
        3)撤销暂存区文件
        git reset HEAD file     #将暂存区的file撤销，千万注意参数--hard这是个危险的操作，不过git rese本身并不危险，他只修改暂存区
        上面的命令能够让file从暂存区移出来，但是对file内容的修改不会变化
        4）撤销对文件的修改
        git checkout -- file  #这条命令可以撤销对文件所做的修改，也就是恢复到最新提交时的状态，这条命令仅在文件还未被添加到暂存区时起作用，若以在暂存区需要先移出暂存区。
        查看远程仓库
        git remote show origin      #origin是默认clone时给远程仓库的命名，通过词条命令可以看见，你使用git pull 和git push 时会带来的变化
        git remote rename origin newname    #修改远程仓库简写名
        git remote rm origin                #移除远程仓库
        打标签：给某个重要的提交打上标签以示重要性，通常用来标记发布节点,git的标签分为轻量标签和附注标签
        git tag         #列出标签，以字母顺序显示
        git tag -a v1.1 -m "my version v1.1"        # -a生成附注标签，-m 给标签添加一条信息，若不加-m选项会默认打开编辑器让你填写标签信息
        git tag v1.2            #直接生成轻量标签，不需要添加其他选项
        git show v1.1           #查看特定标签信息
        共享标签：默认情况下git push 不会将本地的标签推送到远程仓库，必须要显式的推送标签
        git push origin tagname     #连带推送指定标签到远程仓库
        git push origin --tags      #一次性把所有标签推送到远程仓库
        git tag -d tagname          #删除本地指定标签，但不会删除远程
        git push origin :refs/tags/tagname       #移除远程标签
        git 命令别名
        git confi --global alias.br branch  #使用git br 代替git branch
        至此，已经能正常自己使用git了
        emm...  用vim记笔记不能插入图片，这真是个恼人的问题（@-@）
        所以现在放下工作开始折腾笔记软件了（@-@）
        还是想用vim所以首选应该是使用markdown了图片的话正好就存储在GitHub上吧（@-@）
        也或者使用软件moeditor 或者vnote吧（@-@）
        就这样子先开始折腾vim+markdown插件吧（@-@）
### 折腾了vim+vim-makrdown+vim-preview

差不多能正常做笔记了，而且把笔记的图片存储在github上了，引用就方便很多了，（引用的时候注意web上点开具体图片再点download会出现链接，引用那个链接即可）
明天开始先阅读 markdown 语法吧，晚安@-@


### 2019-07-21     

今天就先开始学习一下markdown的语法吧

《markdown语法说明》（简体中文版)

---
```
* #一级标题 
* ##二级标题
* ###三级标题
* ####四级标题
* #####五级标题
* ######六级标题
```

> **这是加粗的文字**      
> *这是倾斜的文字*       
> ***斜体加粗的文字***   
> ~~加删除线的文字~~

图片链接:

![blockchain](https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=702257389,1274025419&fm=27&gp=0.jpg "区块链")

表格：

表头|表头|表头
-|:-:|-:
内容|内容|内容
内容|内容|内容

第二行分割表头和内容。
- 有一个就行，为了对齐，多加了几个
文字默认居左
-两边加：表示文字居中
-右边加：表示文字居右
注：原生的语法两边都要用 | 包起来。此处省略

示例：

姓名|技能|排行
-|:-:|-:
刘备|哭|大哥
关羽|打|二哥
张飞|骂|三弟

行内代码    
`echo "This is al inline context"`


```     
#include"studio.h"
int main()
{
printf("This is a code block with highlight")
}

```
Now to learn git branch 上接 line190

git branch 相当于C语言的指针，如下图        

![git branch](https://raw.githubusercontent.com/way-ww/mypic/master/note/HEAD.png)

HEAD是个特殊的指针，它指向当前所在分支，可以想像为当前分支的别名        

![HEAD](https://raw.githubusercontent.com/way-ww/mypic/master/note/HEAD2.png)           

当执行 `git checkout master` 后HEAD指正从分支重新指回master且将工作目录恢复成master分支所指向的快照内容

频繁的创建使用git分支能够带来很好的体验

### P61~P75 优秀的branch讲解        

git branch -d name-br   # 删除无用的分支
合并就是移动master指针，如果当前master指向的提交就是当前提交的直接上游，这也被称为"快进(fast-forward)"

合并分支时请先切换到master分支

**从远程拉取**      
git fetch origin
git merge origin/servefix
由于git pull的魔法经常令人困惑所以通常显示的使用fetch与merge命令更好些。

到此就告一段落了git
