#!/bin/bash
set -e

echo docker pull tensorflow/tensorflow
docker pull tensorflow/tensorflow

echo docker build -t upskills-workflow-3a .
docker build -t upskills-workflow-3a .

echo docker run -d -p 8888:8888 --name upskills-workflow-3a-container upskills-workflow-3a:latest 
docker run -d -p 8888:8888 --name upskills-workflow-3a-container upskills-workflow-3a:latest 