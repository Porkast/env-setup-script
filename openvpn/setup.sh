docker pull kylemanna/openvpn

export OVPN_DATA=$HOME/openvpn/ovpn_data
export OVPN_CONF_DATA=$OVPN_DATA/conf
export IP=47.243.182.236:1194

mkdir -p $OVPN_DATA
mkdir -p $OVPN_CONF_DATA

# 配置vpn服务端公网ip
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$IP
# 配置管理密码以及自定义证书名称
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
# 创建带有密码用户
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full guoshao
# 生成用户证书文件
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient guoshao > $OVPN_CONF_DATA/guoshao.ovpn
# 启动容器
docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
