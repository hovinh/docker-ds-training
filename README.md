# Docker Training for DS

This repo aims to provide a step-by-step guide that cover some common scenarios in image build of a typical ML project. It is built on top of examples in "Kedro (& Mlflow) for Product Development & MLOps" course. 

## dockerize-anaconda3-pyscript

Objective: Run a container that mounts to host file system (Linux kernel of Container runner, i.e. host) so any data change can be resumed when run the container next time. 

### Prerequisite
Run your Docker Desktop application and pull a prebuilt image. This image is built on top of Anaconda3, in which I create `iris.py` file in the root folder and install nano editor. I intentionally left a grammaticall error at line 16 that will throw a syntax error. 
```bash
$ docker pull hovinh39/dockerize-anaconda3-mountvolumn:latest
latest: Pulling from hovinh39/dockerize-anaconda3-mountvolumn
...
Digest: sha256:9ca8fba3d0f3828a0d66bbd3f7915105476641e042d518b8cd0a0a50b66d9f49
Status: Downloaded newer image for hovinh39/dockerize-anaconda3-mountvolumn:latest
docker.io/hovinh39/dockerize-anaconda3-mountvolumn:latest
```

### Run the image (without mounting the volumn)

Without mounting the container's directory to host, any data change will be lost if you terminate the current container and create a new one from the same image. Let's test it out. 
> **Host** here refers to a runner that plays the role of Linux kernel and "speak" to OS, and this is not Windows kernel that belongs to your physical computer -- check Container terminologies in [master](https://bitbucket.org/hoxuanvinh-upskills/docker-ds-training/src/master/) branch for clarification.

```bash
$ docker run -it --rm hovinh39/dockerize-anaconda3-mountvolumn
root@958b20b7f7cc:/host# dir
iris.py
root@958b20b7f7cc:/host# python iris.py 
  File "/host/iris.py", line 16
    clf = svm.SVC() print(clf)
                    ^
SyntaxError: invalid syntax
```

This is an expected error. We now fix it with nano.
```bash
root@958b20b7f7cc:/host# nano iris.py
\\ Move to line 16 and make a line break and 4 spaces before "print (clf)"
\\ Press Ctrl+O to save, then Enter
\\ Press Ctrl+X to exit
\\ Let's try to run again
root@958b20b7f7cc:/host# python iris.py 
SVC()
Accuracy is 0.933
SVC()
Accuracy is 0.967
SVC()
Accuracy is 0.967
SVC()
Accuracy is 1.000
SVC()
Accuracy is 0.900
```

So we have fixed it. Now end the session and create a new container.
```bash
root@958b20b7f7cc:/host# exit
exit

$ docker run -it --rm hovinh39/dockerize-anaconda3-mountvolumn
root@91286d97d28c:/host# python iris.py 
  File "/host/iris.py", line 16
    clf = svm.SVC() print(clf)
                    ^
SyntaxError: invalid syntax
```
The change you made was not "saved" properly and hence the next session you find things back to square one.

### Run the image (with mounting the volumn)

By stating the argument `-v cd:/host`, we ensure bind mount a volume.
```bash
docker run -it --rm -v cd:/host hovinh39/dockerize-anaconda3-mountvolumn
```
> A **bind mount** makes a file or directory on the host available to the container it is mounted within. A bind mount may be either read-only or read-write. -- Docker documentation --

You can now follow the exact step in the above section and always use `-v cd:/host`, now all changes to be saved. Note that if you do not use the argument, the container won't be able to see the data change, even though it is there.