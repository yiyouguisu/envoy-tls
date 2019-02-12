#!/bin/sh
python3 /code/service.py &
envoy -c /etc/service-envoy.yaml -l info --service-cluster service${SERVICE_NAME}