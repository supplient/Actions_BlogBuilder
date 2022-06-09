FROM pandoc/latex
COPY ./*.sh /data
ENTRYPOINT ["sh", "./work.sh"]
