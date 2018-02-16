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
    pip3 install keras==2.1.4 && \
    pip3 install http://download.pytorch.org/whl/cpu/torch-0.3.1-cp36-cp36m-linux_x86_64.whl && \
    pip3 install torchvision && \

RUN conda update  -y -n python2 scikit-learn && \
    conda install -y -n python2 theano && \
    conda install -y -n python2 -c conda-forge tensorflow && \
    conda install -y -n python2 pydot && \
    conda install -y -n python2 tqdm=4.11.* && \
    pip2 install keras==2.1.* && \
    pip2 install http://download.pytorch.org/whl/cpu/torch-0.3.1-cp27-cp27mu-linux_x86_64.whl && \
    pip2 install torchvision 


RUN pip2 install graphviz      && \
    pip3 install graphviz      && \
    pip2 install plotly==2.3.* && \    
    pip3 install plotly==2.3.* && \    
    pip2 install opencv-contrib-python==3.4.* && \
    pip3 install opencv-contrib-python==3.4.* && \
    pip2 install skdata        && \ 
    # pip  install skdata        && \ 
    pip2 install tqdm          && \ 
    pip3 install tqdm          && \
    pip2 install pydot         && \
    pip3 install pydot

USER $NB_USER

