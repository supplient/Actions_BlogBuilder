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
TODO