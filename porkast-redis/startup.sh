REDIS_WORKSPACE=$HOME/porkast/redis
if [[ ! -e $REDIS_WORKSPACE ]]; then
    mkdir -p $REDIS_WORKSPACE
elif [[ ! -d $REDIS_WORKSPACE ]]; then
    echo "$REDIS_WORKSPACE already exists but is not a directory" 1>&2
fi

docker run -v $REDIS_WORKSPACE/data:/data \
    -v $REDIS_WORKSPACE/logs:/var/log/redis/ \
    -p 6379:6379 \
    --name porkast-redis \
    -d redis:alpine --requirepass 1qaz!QAZ
