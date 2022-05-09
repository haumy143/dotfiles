#!/bin/bash
IP=$(hostname  -I | cut -f1 -d' ') 

if ! command -v docker --version &> /dev/null
then
    echo "docker is not installed"
    exit
else
    docker run -d \
    --net="host" \
    --pid="host" \
    -v "/:/host:ro,rslave" \
    quay.io/prometheus/node-exporter:latest \
    --path.rootfs=/host
    echo "node-exporter is installed"
    echo "add $IP:9100 to Prometheus targets(/etc/prometheus/prometheus.yaml)"
    exit
fi