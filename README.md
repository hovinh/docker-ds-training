# Docker Training for DS

This repo aims to provide a step-by-step guide that cover some common scenarios in image build of a typical ML project. It is built on top of examples in "Kedro (& Mlflow) for Product Development & MLOps" course. 

## dockerize-anaconda3-pyscript

Objective: Build an image with a script inside that is runnable on a pre-built Anaconda (Python 3.X) image.

### Prerequisite
Run your Docker Desktop application.

### Run the image
I have built an exampled image, so you can pull from Docker Hub, run it, and explore inside the container's Terminal to verify the objective is achieved.

- In your Command Prompt, start anywhere:
```bash
$ docker pull hovinh39/dockerize-anaconda3-pyscript:latest 
latest: Pulling from hovinh39/dockerize-anaconda3-pyscript
a603fa5e3b41: Already exists
e732803b8b3a: Already exists
9e99ae6cce8c: Already exists
9c71ca35d491: Already exists
Digest: sha256:b0aec79c5f949f5f211139228a6b356786349f9781aad3e81020f90c1dc74ec2
Status: Downloaded newer image for hovinh39/dockerize-anaconda3-pyscript:latest
docker.io/hovinh39/dockerize-anaconda3-pyscript:latest
```
-  Run the image, i.e. create the container, and verify the `iris.py` is inside `scripts` folder. Simply ignore other arguments in the Docker command for now.
```bash
$ docker run -it --rm dockerize-anaconda3-pyscript:latest 
root@0165504122f6:/# dir
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  scripts  srv  sys  tmp  usr  var
root@0165504122f6:/# cd scripts/
root@0165504122f6:/scripts# ls
iris.py
root@90ee4fee63e8:/scripts# python iris.py 
SVC()
Accuracy is 1.000
root@0165504122f6:/scripts# exit
exit
```

### Build the image
#### **Approach 1:** Build with CLI -- Command Prompt
- Pull the foundational image - Anaconda3.
```bash
$ docker pull continuumio/anaconda3
```
- Ensure the image is downloaded succesfully.
```bash
$ docker images
REPOSITORY                 TAG       IMAGE ID       CREATED       SIZE
continuumio/anaconda3      latest    52531efac757   2 days ago    4.07GB
```
- Run the container in the interactive bash shell (`-it`: keep the STDIN open) and detached mode (`-d`: run container in the background and print container id), with the image ID `52531efac757` (yours would be different).
```bash
$ docker run -it -d 52531efac757
6d6120118285c37035131c7c6ab687ca7c61cf5d92424dcb8bb07a0824f3e1fa
```
- Verify the container is running.
```bash
$ docker ps
CONTAINER ID   IMAGE          COMMAND       CREATED          STATUS          PORTS     NAMES
6d6120118285   52531efac757   "/bin/bash"   23 seconds ago   Up 22 seconds             compassionate_turing
```
- Enter the container's bash shell.
```bash
$ docker exec -it 6d6120118285 bash
root@6d6120118285:/# 
```
- Now add a new layer to the existing image by creating a new directory. You are also supposed to make a new file inside, but I will skip it.
```bash
root@6d6120118285:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@6d6120118285:/# mkdir scripts
root@6d6120118285:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  scripts  srv  sys  tmp  usr  var
root@6d6120118285:/# exit
exit
```
- Now commit this container to a new image by passing the container ID `6d6120118285` (yours would be different). Notice `hovinh39` is my Docker Hub account, I need to add it here with the format `dockerhub-account\my-image` to **tag** it with my account so later can push to Docker Hub. `optional-tag` is another optional tag that serves other purpose, say, version control of your images.
```bash
$ docker ps
CONTAINER ID   IMAGE          COMMAND       CREATED          STATUS          PORTS     NAMES
6d6120118285   52531efac757   "/bin/bash"   24 minutes ago   Up 24 minutes             compassionate_turing
$ docker commit 6d6120118285 hovinh39/dockerize-anaconda3-pyscript::optional-tag
$ docker images
REPOSITORY                 TAG       IMAGE ID       CREATED          SIZE
hovinh39/dockerize-anaconda3-pyscript:    latest    e9504af0f290   14 seconds ago   4.07GB
continuumio/anaconda3      latest    52531efac757   2 days ago       4.07GB
```
- Let's push this image to Docker Hub. If it's failed, you may need to login first with `docker login`. 
```bash
$ docker push hovinh39/dockerize-anaconda3-pyscript::optional-tag
The push refers to repository [docker.io/hovinh39/dockerize-anaconda3-pyscript:]
549666d465f6: Pushed
497abe10839f: Mounted from continuumio/anaconda3
ec4a38999118: Mounted from continuumio/anaconda3
optional-tag: digest: sha256:08a0daca66aa2563d31cf0485703af773b60927573996ff65322cdb7b244a57a size: 950
```
#### **Approach 2**: Build with Dockerfile
- Dockerfile is similar to a shell script that list out all the steps we have done in Approach 1. It's easier to build image this way. I have prepared one in the `workflow` directory. Let's navigate inside that folder and build an image -- notice the `.` at the end of the command indicating that it needs to look for `Dockerfile` in the existing folder, i.e. `workflow`.
```bash
$ cd workflow
$ docker build -t dockerize-anaconda3-pyscript:latest .
[+] Building 0.1s (8/8) FINISHED
 => [internal] load build definition from Dockerfile    0.0s
 => => transferring dockerfile: 31B                     0.0s 
 => [internal] load .dockerignore                       0.0s 
 => => transferring context: 2B                         0.0s 
 => [internal] load metadata for docker.io/continuumio/anaconda3:latest                  0.0s 
 => [1/3] FROM docker.io/continuumio/anaconda3:latest   0.0s
 => [internal] load build context                       0.0s 
 => => transferring context: 29B                        0.0s 
 => CACHED [2/3] RUN mkdir /scripts                     0.0s 
 => CACHED [3/3] COPY iris.py /scripts                  0.0s 
 => exporting to image                                  0.0s 
 => => exporting layers                                 0.0s 
 => => writing image sha256:4b6e3903a25591fa9d9982c47ff17188ad76160c863cafdd596eda3beeb44e43    0.0s 
 => => naming to docker.io/library/dockerize-anaconda3-pyscript:latest      0.0s 
``` 
- Run the image (or create the container) and verify the `iris.py` is inside `scripts` folder. `Dockerfile` is human-readable, so you should also open it and check what the intended action in the image building process were. `--rm` indicates that the container to be removed after its session is closed, hence you will not be able to file it listed after exit the shell.
```bash
$ docker run -it --rm dockerize-anaconda3-pyscript:latest 
root@0165504122f6:/# dir
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  scripts  srv  sys  tmp  usr  var
root@0165504122f6:/# cd scripts/
root@0165504122f6:/scripts# ls
iris.py
root@90ee4fee63e8:/scripts# python iris.py 
SVC()
Accuracy is 1.000
root@0165504122f6:/scripts# exit
exit
$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
- We can now tag the image to the right registry (Docker Hub account) before you can push it. Alternatively, at the time you built the image, you can name it `hovinh39/dockerize-anaconda3-pyscript:latest`.
```bash
$ docker images 
REPOSITORY                     TAG            IMAGE ID       CREATED       SIZE
continuumio/anaconda3          latest         52531efac757   5 days ago    4.07GB
dockerize-anaconda3-pyscript   latest         4b6e3903a255   4 days ago    4.07GB
$ docker tag 4b6e3903a255 hovinh39/dockerize-anaconda3-pyscript:latest
$ docker push hovinh39/dockerize-anaconda3-pyscript:latest 
The push refers to repository [docker.io/hovinh39/dockerize-anaconda3-pyscript]
04f33cfc4d94: Pushed
ab25cef981e2: Pushed
latest: digest: sha256:b0aec79c5f949f5f211139228a6b356786349f9781aad3e81020f90c1dc74ec2 size: 1157
```

#### **Approach 3**: Automate further with Bash shell script.
Instead of typing into Command Prompt, we can automate with a Bash shell script. However, I was unable to run it as expected on Windows; this was originally prepared by Tuyen (ductuyen.ta@upskills.ai). Please feel free to make a PR to improve this document if you are able to make it work.