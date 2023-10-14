DB_HOME=$HOME/porkast/mysqldb/
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

echo "run porkast-mysqldb container"

docker run --name porkast-mysqldb -p 3306:3306 --cpus=1 -v $DB_CONFIG_DIR:/etc/mysql/conf.d -v $LOGS_DIR:/app/logs -v $DATA_DIR:/var/lib/mysql -d beegedelow/porkast-mysqldb:latest
