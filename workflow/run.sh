#!/bin/bash
set -e

echo docker pull continuumio/anaconda3
docker pull continuumio/anaconda3

echo docker build -t upskills-workflow-2b .
docker build -t upskills-workflow-2b .

echo "Entering docker shell, type \"exit\" to return back to host shell"
echo docker run -it --rm -v cd:/host upskills-workflow-2b:latest /bin/bash
docker run -it --rm -v cd:/host upskills-workflow-2b:latest /bin/bash
