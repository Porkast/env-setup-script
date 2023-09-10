ES_HOME=$HOME/guoshaofm/es
ES_DATA_DIR=$ES_HOME/data
if [[ ! -e $ES_DATA_DIR ]]; then
    mkdir -p $ES_DATA_DIR
elif [[ ! -d $ES_DATA_DIR ]]; then
    echo "$ES_DATA_DIR already exists but is not a directory" 1>&2
fi
ES_IK_CONFIG_DIR=$ES_HOME/config/analysis-ik
if [[ ! -e $ES_IK_CONFIG_DIR ]]; then
    mkdir -p $ES_IK_CONFIG_DIR
elif [[ ! -d $ES_IK_CONFIG_DIR ]]; then
    echo "$ES_IK_CONFIG_DIR already exists but is not a directory" 1>&2
fi
ES_PLUGINS_DIR=$ES_HOME/plugins
if [[ ! -e $ES_PLUGINS_DIR ]]; then
    mkdir -p $ES_PLUGINS_DIR
elif [[ ! -d $ES_PLUGINS_DIR ]]; then
    echo "$ES_PLUGINS_DIR already exists but is not a directory" 1>&2
fi
chmod -R 777 $ES_HOME

docker run --name elasticsearch --network host \
        --log-opt max-size=500m --log-opt max-file=3 \
        -e "discovery.type=single-node"\
        -e ES_JAVA_OPTS="-Xms128m -Xmx1024m" \
        -e ELASTIC_USERNAME=elastic \
        -e ELASTIC_PASSWORD=qazxsw \
        -e xpack.security.enabled=true \
        -v $ES_DATA_DIR:/usr/share/elasticsearch/data \
        -v $ES_PLUGINS_DIR:/usr/share/elasticsearch/plugins \
        -v $ES_IK_CONFIG_DIR:/usr/share/elasticsearch/config/analysis-ik \
        -d elasticsearch:7.17.5

# ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.17.5/elasticsearch-analysis-ik-7.17.5.zip