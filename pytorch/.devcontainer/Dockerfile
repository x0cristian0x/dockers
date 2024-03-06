FROM pytorch/pytorch:2.2.1-cuda11.8-cudnn8-runtime
     
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y # para opencv

RUN conda install -n base ipykernel --update-deps --force-reinstall -y

RUN conda install conda-forge::opencv -y
RUN conda install conda-forge::imageio -y
RUN conda install conda-forge::pandas -y
RUN conda install conda-forge::matplotlib -y
RUN conda install conda-forge::torchmetrics -y
RUN conda install conda-forge::mlxtend -y
RUN conda install conda-forge::torchinfo -y
RUN conda install conda-forge::scikit-learn -y
RUN conda install conda-forge::graphviz -y
RUN conda install conda-forge::tensorboard -y
RUN pip install torchsummary
RUN pip install torchviz









