DB_DATA_DIR=$HOME/guoshaofm/mariadb/datadir
if [[ ! -e $DB_DATA_DIR ]]; then
    mkdir -p $DB_DATA_DIR
elif [[ ! -d $DB_DATA_DIR ]]; then
    echo "$DB_DATA_DIR already exists but is not a directory" 1>&2
fi
docker run --name guoshaofm-mariadb -v $DB_DATA_DIR:/var/lib/mysql -d mariadb:latest
