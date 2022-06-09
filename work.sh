md_dir="$1"
html_dir="$2"
title="$3"
css_file="$4"

echo "title: ${title}"
echo "css_file: ${css_file}"
echo "md_dir: ${md_dir}"
echo "html_dir: ${html_dir}"

# ???
echo "[Debug Start]"
echo "ls ${md_dir}"
ls ${md_dir}
echo "ls /home/runner/work/GithubActionTest/GithubActionTest"
ls /home/runner/work/GithubActionTest/GithubActionTest
echo "[Debug End]"

# 创建输出目录以免不存在，-R是为了在目录已存在时也不会报错
mkdir -p $html_dir

# 拷贝资源文件 # TODO: .md文件其实可以不用拷贝
echo "Copying files ......"
cp -R ${md_dir}/* ${html_dir}

# 生成目录文件
echo "Generating index.md ......"
sh /make_index.sh ${md_dir}

# markdown=>html
echo "Converting markdown to html: ${md_dir} => ${html_dir} ......"
sh /convert.sh -t ${title} -c ${css_file} ${md_dir} ${html_dir}