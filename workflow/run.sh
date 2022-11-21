#!/bin/bash
set -e

echo docker pull continuumio/anaconda3
docker pull continuumio/anaconda3

echo docker build -t upskills-workflow-1 .
docker build -t upskills-workflow-1 .

echo docker run -it --rm upskills-workflow-1:latest /opt/conda/bin/python /scripts/iris.py
docker run -it --rm upskills-workflow-1:latest /opt/conda/bin/python /scripts/iris.py
