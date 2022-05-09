#!/bin/bash
IP=$(hostname  -I | cut -f1 -d' ') 

if ! command -v docker --version &> /dev/null
then
    read -p "docker is not installed! Do you want to apt install Docker.io now?(y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
    apt-get install docker.io -y
    fi
fi

docker run -d \
--net="host" \
--pid="host" \
-v "/:/host:ro,rslave" \
quay.io/prometheus/node-exporter:latest \
--path.rootfs=/host
echo "node-exporter is now installed"
echo "####################### add $IP:9100 to Prometheus targets(/etc/prometheus/prometheus.yaml) #######################"
exit