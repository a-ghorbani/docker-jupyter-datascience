Data Science on Docker
==========


A Docker image for Data science.

This Docker image depends on [Jupyter's Data Science notebook](https://hub.docker.com/r/jupyter/datascience-notebook/).

## Pull the image from Docker Repository

```
docker pull aghorbani/jupyter-datascience
```

## Building the image

```
docker build --rm -t aghorbani/jupyter-datascience .
```

## Running the image

```
docker run -it --rm -p 8888:8888 \
           -v /PATH/TO/LOCAL/DIR/:/home/jovyan/work \
           aghorbani/jupyter-datascience start-notebook.sh --NotebookApp.token=''
```


