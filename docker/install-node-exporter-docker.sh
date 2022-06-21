#!/bin/bash
IP=$(hostname  -I | cut -f1 -d' ')
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

if ! command -v docker --version &> /dev/null
then
    read -p "docker is not installed! Do you want to apt install Docker.io now?(y/n):" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
        apt-get update
        apt-get install docker.io -y
    else
        exit
    fi
fi

docker run -d \
--net="host" \
--pid="host" \
-v "/:/host:ro,rslave" \
--restart always \
quay.io/prometheus/node-exporter:latest \
--path.rootfs=/host

echo -e "${GREEN}node-exporter container is now installed${NC}"
echo -e "Add ${YELLOW}$IP:9100${NC} to Prometheus targets(/etc/prometheus/prometheus.yaml)"
exit