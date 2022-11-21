# Docker Training for DS

This repo aims to provide a step-by-step guide that cover some common scenarios in image build of a typical ML project. It is built on top of examples in "Kedro (& Mlflow) for Product Development & MLOps" course. 

## dockerize-anaconda3-jupyternotebook

Objective: Build an image with runnable Jupyter notebook.

### Prerequisite

Run your Docker Desktop application.

## Run the image
- Pull the image from Docker Hub:
```bash
$ docker pull hovinh39/dockerize-anaconda3-jupyternotebook:latest
latest: Pulling from hovinh39/dockerize-anaconda3-jupyternotebook
Digest: sha256:92e4ffd31408e4423ed622c0e6f8a32011b87ac40c4b56a80b99bc8adb519d78
Status: Image is up to date for hovinh39/dockerize-anaconda3-jupyternotebook:latest
docker.io/hovinh39/dockerize-anaconda3-jupyternotebook:latest
```

- Run the container and execute the jupyter notebook. We will access via `port 8888` (ensure that there is no other container is using this port). 
```bash
$ docker run -d -p 8888:8888 hovinh39/dockerize-anaconda3-jupyternotebook
d0c12122f97d464f4bc7438b4b34cf400fcaa2896f94fae881cc5dc5026ea76b
```

- In your browser, enter `http://localhost:8888/` in the address bar and enter the password `test` (check `Dockerfile` to see how this is setup). You should now be able to run the `tensorflow_example.ipynb` with all relevant packages pre-installed.

## Build the image

- Navigate to `workflow` folder and start the building. Notice how the `Dockerfile` is written: it has foundational image is `tensorflow/tensorflow:latest-py3`, copies the `tensorflow_example.ipynb` into the image, then trigger `run_jupyter.sh`. Therefore, that means if we run the container, it will also run the commands inside `run_jupyter.sh`. Also, the password to access the notebook is set to `test`. For a more secured approach, please check `workflow/secure_run.sh`.
```bash
$ cd workflow
$ docker build -t hovinh39/dockerize-anaconda3-jupyternotebook .
[+] Building 1.5s (16/16) FINISHED
 => [internal] load build definition from   Dockerfile  0.0s
 => => transferring dockerfile: 32B 0.0s 
 => [internal] load .dockerignore   0.0s 
 => => transferring context: 2B 0.0s 
 => [internal] load metadata for docker.io/tensorflow/tensorflow:latest-py3 0.9s 
 => [internal] load build context   0.0s
 => => transferring context: 8.47kB 0.0s 
 => [ 1/11] FROM docker.io/tensorflow/tensorflow:latest-py3@sha256:14ec674cefd622aa9d45f07485500da254acaf8adfef80bd0f279db03c735689 0.0s 
 => CACHED [ 2/11] RUN python3 -V  && pip install --upgrade pip 0.0s 
 => CACHED [ 3/11] RUN pip3 install jupyter==1.0.0     jupyter-contrib-nbextensions==0.5.1     jupyter-nbextensions-configurator==0.4.1     jupyternotify==0.1.15   0.0s 
 => CACHED [ 4/11] RUN apt-get update   0.0s 
 => CACHED [ 5/11] RUN apt-get install -y git-core  0.0s 
 => CACHED [ 6/11] RUN mkdir -p /notebooks  0.0s 
 => [ 7/11] COPY tensorflow_example.ipynb /notebooks    0.0s 
 => [ 8/11] COPY run_jupyter.sh /notebooks  0.0s
 => [ 9/11] COPY run.sh /notebooks  0.0s 
 => [10/11] WORKDIR /notebooks  0.0s 
 => [11/11] RUN ls -al  0.3s
 => exporting to image  0.1s 
 => => exporting layers 0.0s 
 => => writing image sha256:d8aee2bbc5798e034108048866cf22b41f944cb70706dcef39ce2252613f17da    0.0s 
 => => naming to docker.io/hovinh39/dockerize-anaconda3-jupyternotebook 
```
- Push the image:
```bash
$ docker push hovinh39/dockerize-anaconda3-jupyternotebook:latest
```