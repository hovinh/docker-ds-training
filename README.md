# Docker Training for DS

This repo aims to provide a step-by-step guide that cover some common scenarios in image build of a typical ML project. It is built on top of examples in "Kedro (& Mlflow) for Product Development & MLOps" course. 

## Getting-started

Download and install [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/). Video for reference is on [Youtube](https://www.youtube.com/watch?v=hczW_L3a2gk&ab_channel=S3CloudHub). Just press Next during the installation process, and it may ask you to install WSL2 if your computer does not have yet. To install WSL2, simply follow the instruction link at [step 4](https://learn.microsoft.com/en-sg/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package),

## Materials
Terminologies is one challenge I face when working with Docker; understanding the right usage in the right context enables more efficency in collaboration, even though the typical workflow could be viewed similar to working with Git. 

> Often teams start with installing a Container Host, then pulling some Container Images. Then they move on to building some new Container Images and pushing them to a Registry Server to share with others on their team. After a while they want to wire a few containers together and deploy them as a unit. Finally, at some point, they want to push that unit into a pipeline (Dev/QA/Prod) leading towards production.
-- Scott McCarty, Red Hat --

I advise to try out the tutorial branch [dockerize-anaconda3-pyscript](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/src/dockerize-anaconda3-pyscript/) before reading this very good blog to appreciate and gain better clarity on container terminology.

- [A Practical Introduction to Container Terminology](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction#)


Commonly used Docker commands:

| Command     | Definition |
| --------|---------|
| `docker pull NAME[:TAG]`   | Pull image from container registry DockerHub to local with NAME is the image name.   |
| `docker push NAME[:TAG]`   | Push image from local to container registry DockerHub with NAME is the image name.   |
| `docker build NAME[:TAG] PATH`| Build the image with Dockerfile can be found in `PATH`.|
| `docker tag SOURCE_IMAGE[:TAG] TARGET_IAMGE[:TAG]`| Commit or "rename" the existing image with container registry before you push it. |
| `docker run -it --rm NAME[:TAG]`  | Execute the container and enter its terminal. Container to be removed right after the session ends. | 
| `docker run -it --rm -v MOUNTED_HOST_DIR NAME[:TAG]`  | Execute the container and enter its terminal. Container to be removed right after the session ends. Bind mount a volumn to host so data change to be saved. | 
| `docker run -it CONTAINER-ID` | Execute the container and have it running in the back ground.
| `docker images` | List out images in the local. |
| `docker ps` | List out running containers in the local. |

## Repo Structure

The repo will have multiple branches, each corresponding to one template workflow. Each template consists of two parts: (1) running the docker image had been built by me that is archived on DockerHub; and (2) build your own docker image.

The workflow list consists of:

1.  [dockerize-anaconda3-pyscript](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/src/dockerize-anaconda3-pyscript/): build an image with a new script that is runnable on a pre-built Anaconda (Python 3.X) image.
2.  [dockerize-anaconda3-mountvolumn](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/src/dockerize-anaconda3-mountvolumn/): run a container that mounts to host file system (Linux kernel of Container runner, i.e. host) so any data change can be resumed when run the container next time.
3.  [dockerize-anaconda3-jupyternotebook](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/src/dockerize-anaconda3-jupyternotebook/): build an image with runnable Jupyter notebook.
4.  [dockerize-anaconda3-condaenv](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/src/dockerize-anaconda3-condaenv/): build an image with pre-made Anaconda environment.
5.  [dockerize-anaconda3-interact-multicontainers](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/branch/dockerize-anaconda3-interact-multicontainers): call out for contribution -- run two or more containers altogether and can interact/communicate among them; potentially make use of DockerCompose. 
