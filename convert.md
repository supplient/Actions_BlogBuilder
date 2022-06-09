本文档讲解博客文件生成过程。

一句话：`bash ./docker.sh`

过程：启动一个docker container，镜像为pandoc/latex，随后在这个container里面执行工作脚本

# 拷贝资源文件
一句话：`cp -R ./md/* ./html`

不然html文件索引不到图片、视频之类的。

# 生成目录文件index.md
一句话：`bash ./make_index.sh ./md`

* `make_index.sh`：生成index.md的脚本文件

结果：会递归地给每个目录都生成一个形似下文的index.md。

* 遍历到.md文件时，生成到.html的条目
* 遍历到子目录时，生成到子目录的index.html的条目

``` markdown
[并行问题_offset2index.html](并行问题_offset2index.html)

[C++检查模板参数的成员函数是否具有指定签名.html](C++检查模板参数的成员函数是否具有指定签名.html)

[CUDA中原子锁的实现.html](CUDA中原子锁的实现.html)

[GPU数据结构设计模式.html](GPU数据结构设计模式.html)

[PD_reading](PD_reading/index.html)

[XPBD_reading](XPBD_reading/index.html)

```

# markdown => html的转换
一句话：`bash ./convert.sh`。

* `convert.sh`：markdown=>html的转换脚本，需要pandoc

过程：最核心的脚本是`convert.sh`，但它需要pandoc，所以我们先启动一个container，把pandoc/latex这个镜像给拉下来，然后在这个container里执行`convert.sh`。



