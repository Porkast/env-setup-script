DB_DATA_DIR=$HOME/guoshaofm/zincsearch/data
if [[ ! -e $DB_DATA_DIR ]]; then
    mkdir -p $DB_DATA_DIR
elif [[ ! -d $DB_DATA_DIR ]]; then
    echo "$DB_DATA_DIR already exists but is not a directory" 1>&2
fi


docker run -v $DB_DATA_DIR:/data \
    -e ZINC_DATA_PATH="/data" \
    -p 4080:4080 \
    -e ZINC_FIRST_ADMIN_USER=admin \
    -e ZINC_FIRST_ADMIN_PASSWORD=1qaz!QAZ \
    -e ZINC_PLUGIN_GSE_ENABLE=true \
    -e ZINC_PLUGIN_GSE_HMM_ENABLE=false \
    -e ZINC_PLUGIN_GSE_DICT_EMBED=big \
    --name guoshaofm-zincsearch public.ecr.aws/zinclabs/zincsearch:0.4.6

