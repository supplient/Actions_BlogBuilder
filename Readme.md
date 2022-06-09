# BlogBuilder

自用Action，会做三件事情：

1. 拷贝所有文件到目标目录下
2. 为每个目录生成一个`index.md`，内容为到该目录下的`.md`文件的索引项和到子目录的`index.md`的索引项
3. 将所有.md文件都使用pandoc转换成html文件，放到目标目录下，并将`index.html`下到.md文件的索引也替换为到对应.html文件的索引。

细节的过程请参阅[convert.md](./convert.md)

# Usage

``` yaml
- uses: supplient/Actions_BlogBuilder@main
  with:
    # required 源目录，会处理该目录下的文件。注意index.md也会生成在该目录中
    markdown_dir: ./md
    # required 目标目录，会输出到该目录下
    html_dir: ./html
    # optional 标题，会显示在每一页的顶部。默认为"My Blog"
    title: "My Blog"
    # optional pandoc使用的css文件，详情请参阅https://pandoc.org/MANUAL.html#option--css
    css_file: "https://gist.githubusercontent.com/supplient/1726b3acbfed278f54b66cf11129a43b/raw/62b874d98f72005d18b9b2a05d3be6815959b51b/gh-pandoc.css"
```

# Scenarios
假设有一个markdown的库，我们希望从它建立一个博客。假设它的目录结构为：

```
a.md
graph
  b.md
  bg.png
extra
  c.md
  cg.html
```

为其设立Workflow，其`main.yml`如下：

``` yaml
name: Build Page => gh_pages

# 设定为当main分支有新分支时被启动
on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build:
    # 只能在linux系统的host runner上跑
    runs-on: ubuntu-latest

    steps:
      - name: Build temporary directory
        run: mkdir -p "${{ github.workspace }}/md"

      - name: Checkout
        uses: actions/checkout@v3
        with:
          path: "${{ github.workspace }}/md"

      - name: Blog Builder
        uses: supplient/Actions_BlogBuilder@main
        with:
          markdown_dir: "/github/workspace/md"
          html_dir: "/github/workspace/html"
          title: "测试用博客"
        
      - name: Deploy to gp-pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: "${{ github.workspace }}/html"
```

则每当main分支有新的commit被提交时，该workflow就会在gh-pages分支下生成对应的html文件。gh-pages分支下的目录结构将为：

```
index.md
a.html
a.md
graph
  index.md
  b.html
  b.md
  bg.png
extra
  index.md
  c.html
  c.md
  cg.html
```

如果启用github page，并将其源目录设为gh-page分支的根目录，则会因为gh-pages的变动而进一步触发github自动设立的pages-build-depolyment Workflow，从而更新github page。


# Limitations
* 目前不支持文件名里带空格