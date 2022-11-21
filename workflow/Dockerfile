# Define base image
FROM continuumio/miniconda3
 
# Set working directory for the project
WORKDIR /app
 
# Create Conda environment from the YAML file
COPY environment.yml .
RUN conda env create -f environment.yml
 
# Override default shell and use bash
SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]
 
# Activate Conda environment and check if it is working properly
RUN echo "Making sure flask is installed correctly..."
RUN python -c "import flask"
 
# Python program to run in the container
COPY run.py .
ENTRYPOINT ["conda", "run", "-n", "env", "python", "run.py"]