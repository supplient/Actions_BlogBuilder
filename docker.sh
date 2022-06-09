# 本文件封装了传递给docker run的参数
	# --user: 为了避免转换得到的html文件的所有者为root，指定当前用户
    # --volume: 挂载当前目录到pandoc的工作目录/data
    # --entrypoint: 默认的entrypoint是pandoc，但我们需要执行脚本，所以改为sh
	# pandoc/latex: 因为需要pandoc环境，所以pull这个镜像
	# /data/work.sh: 工作脚本
docker run \
	--user "$(id -u):$(id -g)" \
	--volume `pwd`:"/data" \
	--entrypoint "sh" \
	pandoc/latex \
	./work.sh



#########如果使用docker-compose############
# 本文件封装了传递临时环境变量给docker-compose的过程
# tmp_uid=$(id -u) tmp_gid=$(id -g) docker-compose up

####docker-compose.yml####
# services:
  # pandoc:
    # # https://hub.docker.com/r/pandoc/latex
    # image: pandoc/latex
    # # 为了避免转换得到的html文件的所有者为root，指定当前用户
    # user: "${tmp_uid}:${tmp_gid}"
    # # 挂载当前目录到pandoc的工作目录/data
    # volumes:
      # - .:/data
    # # container启动后就立即执行convert.sh，进行转换工作
    # entrypoint: sh /data/convert.sh
