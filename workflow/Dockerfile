FROM tensorflow/tensorflow:latest-py3
RUN python3 -V  && pip install --upgrade pip

RUN pip3 install jupyter==1.0.0 \
    jupyter-contrib-nbextensions==0.5.1 \
    jupyter-nbextensions-configurator==0.4.1 \
    jupyternotify==0.1.15

# tensorflow examples no longer contained in tensorflow docker image
RUN apt-get update
RUN apt-get install -y git-core

RUN mkdir -p /notebooks
COPY tensorflow_example.ipynb /notebooks
COPY run_jupyter.sh /notebooks
COPY run.sh /notebooks

ENV PASSWORD test

WORKDIR /notebooks
RUN ls -al

CMD ["./run_jupyter.sh"]
