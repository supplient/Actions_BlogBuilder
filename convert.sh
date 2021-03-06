# usage: bash convert.sh md_dir html_dir title css_file_url
# 本文件封装了markdown=>html的转换过程
# 执行后会遍历md_dir中的所有.md文件，利用pandoc转换为html文件，并输出到html_dir中。
# html_dir下的目录结构会与md_dir保持一致，不存在的目录则会被新建。

# Deprecated: seems `sh` not support getopts
#while getopts "t:c:" OPT
#do
	#case "$OPT" in
	#t)	title="$OPTARG";;
	#c)	css_file="$OPTARG";;
	#[?]) echo "Usage: $0 markdown_dir html_dir [-t title] [-c css_file]"
		#echo "	-t: default \"My Blog\""
		#echo "	-c: default \"https://gist.githubusercontent.com/supplient/1726b3acbfed278f54b66cf11129a43b/raw/62b874d98f72005d18b9b2a05d3be6815959b51b/gh-pandoc.css\""
		#exit 1;;
	#esac
#done


# 处理输出选项
src_root=${1} # markdown dir
dst_root=${2} # html dir
title=${3}
css_file=${4}

# Log
echo "title: ${title}"
echo "css_file: ${css_file}"
echo "md_dir: ${src_root}"
echo "html_dir: ${dst_root}"

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