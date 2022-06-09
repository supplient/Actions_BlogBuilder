FROM pandoc/latex
COPY ./*.sh ${GITHUB_WORKSPACE}
ENTRYPOINT ["sh", "./work.sh"]
