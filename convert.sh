# usage: bash convert.sh [-t title] [-c css_file_url] md_dir html_dir
# 本文件封装了markdown=>html的转换过程
# 执行后会遍历md_dir中的所有.md文件，利用pandoc转换为html文件，并输出到html_dir中。
# html_dir下的目录结构会与md_dir保持一致，不存在的目录则会被新建。


# 处理输出选项
title="My Blog"
css_file="https://gist.githubusercontent.com/supplient/1726b3acbfed278f54b66cf11129a43b/raw/62b874d98f72005d18b9b2a05d3be6815959b51b/gh-pandoc.css"
while getopts "t:c:" OPT
do
	case "$OPT" in
	t)	title="$OPTARG";;
	c)	css_file="$OPTARG";;
	[?]) echo "Usage: $0 [-t title] [-c css_file] markdown_dir html_dir"
		echo "	-t: default \"My Blog\""
		echo "	-c: default \"https://gist.githubusercontent.com/supplient/1726b3acbfed278f54b66cf11129a43b/raw/62b874d98f72005d18b9b2a05d3be6815959b51b/gh-pandoc.css\""
		exit 1;;
	esac
done
src_root=${@:$OPTIND:1} # markdown dir
dst_root=${@:$OPTIND+1:1} # html dir

# 遍历所有.md文件
# TODO: If there is space in the filename, for-loop will separete the filename
files=`find "${src_root}" -name "*.md"`
for src_file in $files
do
	# .md文件相对于src_root的相对路径
	rel_path="./${src_file#${src_root}/}"
	# 文件名，含后缀
	file="${src_file##*/}"
	# 目标文件夹
	dst_dir="${dst_root}/${rel_path%/*}"
	# 目标文件名，含后缀
	dst_file="${dst_dir}/${file%.*}.html"

	echo "Processing ${src_file}"
	# 创建目录
	mkdir -p $dst_dir
	# 使用pandoc进行转换
		# --mathjax: 在生成的html的header部分插入mathjax的cdn
		# --t html: 等价于--to=html
		# -s: standalone，生成包含header的html文件，否则就只有内容部分
		# --css: 指定css文件
		# --metadata title: 指定标题（TODO：其实我不想要标题的……但似乎不可去除。不过现在看来标题也可以用来当导航栏）
		# -o: 指定输出文件
	pandoc \
		--mathjax \
		-t html \
		-s \
		--css="$css_file" \
		--metadata title:"$title" \
		-o "$dst_file" \
		"$src_file"
done