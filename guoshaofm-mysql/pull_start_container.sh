echo "stop guoshaofm-mysqldb"
docker stop guoshaofm-mysqldb
echo "remove guoshaofm-mysqldb container"
docker container rm guoshaofm-mysqldb
echo "remove beegedelow/guoshaofm-mysqldb image"
docker rmi beegedelow/guoshaofm-mysqldb
echo "pull beegedelow/guoshaofm-mysqldb image"
docker pull beegedelow/guoshaofm-mysqldb

DB_HOME=$HOME/guoshaofm/mysqldb/
LOGS_DIR=$DB_HOME/logs
if [[ ! -e $LOGS_DIR ]]; then
    mkdir -p $LOGS_DIR
elif [[ ! -d $LOGS_DIR ]]; then
    echo "$LOGS_DIR already exists but is not a directory" 1>&2
fi

DATA_DIR=$DB_HOME/datadir
if [[ ! -e $DATA_DIR ]]; then
    mkdir -p $DATA_DIR
elif [[ ! -d $DATA_DIR ]]; then
    echo "$DATA_DIR already exists but is not a directory" 1>&2
fi

DB_CONFIG_DIR=$DB_HOME/config
if [[ ! -e $DB_CONFIG_DIR ]]; then
    mkdir -p $DB_CONFIG_DIR
elif [[ ! -d $DB_CONFIG_DIR ]]; then
    echo "$DB_CONFIG_DIR already exists but is not a directory" 1>&2
fi

echo "run guoshaofm-mysqldb container"

docker run --name guoshaofm-mysqldb -p 3306:3306 --cpus=1 -v $DB_CONFIG_DIR:/etc/mysql/conf.d -v $LOGS_DIR:/app/logs -v $DATA_DIR:/var/lib/mysql -d beegedelow/guoshaofm-mysqldb:latest
