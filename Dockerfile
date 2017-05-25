FROM jupyter/datascience-notebook 
MAINTAINER Asghar Ghorbani [https://de.linkedin.com/in/aghorbani

USER root

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  libopenblas-dev \
  libopencv-dev \
  python-dev \
  python-numpy \
  python-setuptools \
  wget \
  graphviz

# Clone MXNet repo and move into it
RUN cd /root && git clone --recursive https://github.com/dmlc/mxnet && cd mxnet && \
# Copy config.mk
  cp make/config.mk config.mk && \
# Set OpenBLAS
  sed -i 's/USE_BLAS = atlas/USE_BLAS = openblas/g' config.mk && \
# Make 
  make -j"$(nproc)"


# Install Python package
RUN cd /root/mxnet/python && \
    /opt/conda/bin/python setup.py install && \
    /opt/conda/envs/python2/bin/python setup.py install

RUN conda update  -y conda && \
    conda update  -y scikit-learn && \
    conda install -y theano && \
    conda install -y -c conda-forge tensorflow && \
    conda install -y tqdm=4.11.* && \
    pip   install keras==2.0.4
    #pip install git+git://github.com/fchollet/keras.git 

RUN conda update  -y -n python2 scikit-learn && \
    conda install -y -n python2 theano && \
    conda install -y -n python2 -c conda-forge tensorflow && \
    conda install -y -n python2 pydot && \
    conda install -y -n python2 tqdm=4.11.* && \
    pip2  install keras==2.0.4
    #pip2 install git+git://github.com/fchollet/keras.git


RUN pip2 install graphviz      && \
    pip  install graphviz      && \
    pip2 install plotly==2.0.* && \    
    pip  install plotly==2.0.* && \    
    pip2 install opencv-contrib-python==3.2.* && \
    pip  install opencv-contrib-python==3.2.* && \
    pip2 install skdata        && \ 
    # pip  install skdata        && \ 
    pip2 install tqdm          && \ 
    pip  install tqdm 

USER $NB_USER

