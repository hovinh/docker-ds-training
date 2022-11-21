# Docker Training for DS

This repo aims to provide a step-by-step guide that cover some common scenarios in image build of a typical ML project. It is built on top of examples in "Kedro (& Mlflow) for Product Development & MLOps" course. 

## dockerize-anaconda3-condaenv:

Objective: build an image with pre-made Anaconda environment.

On courtesy of Keval Nagda's tutorial: https://kevalnagda.github.io/conda-docker-tutorial

### Prerequisite
Run your Docker Desktop application.

### Run the image
I have built an exampled image, so you can pull from Docker Hub, run it, and explore inside the container's Terminal to verify the objective is achieved.

- In your Command Prompt, start anywhere. Here we intendedly have the top layer is the execution of `run.py` to verify the package Flask is installed successfully:
```bash
$ docker pull hovinh39/dockerize-anaconda3-condaenv:latest
$ docker run -it --rm hovinh39/dockerize-anaconda3-condaenv
Flask import successful!
```

### Build the image

- Here we will use the lightweighted `continuumio/miniconda3` as the foundational image. A conda environment will be created with the package content in the `environment.yml` via conda command. We will also execute `run.py` to ensure the package is installed successfully.
```bash
$ cd workflow
$ docker build -t hovinh39/dockerize-anaconda3-condaenv .
[+] Building 124.1s (12/12) FINISHED
 => [internal] load build definition from Dockerfile    0.0s
 => => transferring dockerfile: 32B 0.0s 
 => [internal] load .dockerignore   0.0s 
 => => transferring context: 2B 0.0s 
 => [internal] load metadata for docker.io/continuumio/miniconda3:latest    0.9s 
 => [internal] load build context   0.0s
 => => transferring context: 121B   0.0s 
 => [1/7] FROM docker.io/continuumio/miniconda3@sha256:977263e8d1e476972fddab1c75fe050dd3cd17626390e874448bd92721fd659b 17.8s 
 => => resolve docker.io/continuumio/miniconda3@sha256:977263e8d1e476972fddab1c75fe050dd3cd17626390e874448bd92721fd659b 0.0s 
 => => sha256:977263e8d1e476972fddab1c75fe050dd3cd17626390e874448bd92721fd659b 1.36kB / 1.36kB  0.0s 
 => => sha256:58b1c7df8d69655ffec017ede784a075e3c2e9feff0fc50ef65300fc75aa45ae 953B / 953B  0.0s 
 => => sha256:ce7d119281a1f4685ce6ca66b355c88baa44522ac6a54aee86be96d14ab6dfda 4.36kB / 4.36kB  0.0s 
 => => sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda 31.38MB / 31.38MB    9.4s 
 => => sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39 50.06MB / 50.06MB    14.3s 
 => => sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09 60.29MB / 60.29MB    13.0s 
 => => extracting sha256:42c077c10790d51b6f75c4eb895cbd4da37558f7215b39cbf64c46b288f89bda   1.6s
 => => extracting sha256:1a23c9d790a34c5bb13dbaf42e0ea2a555e089aefed7fdfa980654f773b39b39   1.3s
 => => extracting sha256:22a6fc63b9b529f00082379be512f0ca1c7a491872396994cf59b47e794c5e09   1.9s
 => [2/7] WORKDIR /app  0.5s 
 => [3/7] COPY environment.yml .    0.0s 
 => [4/7] RUN conda env create -f environment.yml   96.9s 
 => [5/7] RUN echo "Making sure flask is installed correctly..."    4s 
 => [6/7] RUN python -c "import flask"  1.8s 
 => [7/7] COPY run.py . 0.0s 
 => exporting to image  4.7s 
 => => exporting layers 4.7s 
 => => writing image sha256:95c0b50dc47b0296e7e4a5924b939d343f42e1cf5282eaf2a115ef3eaabba9e6    0.0s 
 => => naming to docker.io/hovinh39/dockerize-anaconda3-condaenv
```
- Push the image into the Docker Hub.
```bash
docker push hovinh39/dockerize-anaconda3-condaenv:latest
```