# export DOCKER_CLI_EXPERIMENTAL=enabled
# docker login --username beegedelow -p dckr_pat_Lk95JktVqEmX9oam1AyBlmOUZrc
# docker build -t beegedelow/guoshaofm-mysqldb .
docker buildx build --platform=linux/amd64 -t beegedelow/porkast-mysqldb .

