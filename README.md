# Docker Training for DS

This repo aims to provide a step-by-step guide that cover some common scenarios in image build of a typical ML project. It is built on top of examples in "Kedro (& Mlflow) for Product Development & MLOps" course. 

## Getting-started

Download and install [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/). Video for reference is on [Youtube](https://www.youtube.com/watch?v=hczW_L3a2gk&ab_channel=S3CloudHub). Just press Next during the installation process, and it may ask you to install WSL2 if your computer does not have yet. Simply follow the instruction link at [step 4](https://learn.microsoft.com/en-sg/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package),


## Repo Structure

The repo will have multiple branches, each corresponding to one template workflow. Each template consists of two parts: (1) running the docker image had been built by me that is archived on DockerHub; and (2) build your own docker image.

The workflow list consists of:
- dockerize-anaconda3-pyscript: build a container with a new script that is runnable on a pre-built Anaconda (Python 3.X) image.