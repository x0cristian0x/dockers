FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-runtime
#FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime
RUN conda install -n base ipykernel --update-deps --force-reinstall -y


# book pytorch benning
RUN conda install conda-forge::graphviz -y
RUN conda install conda-forge::tensorboard -y
RUN pip install torchviz
RUN conda install conda-forge::imageio -y
RUN conda install conda-forge::matplotlib
RUN conda install conda-forge::scikit-learn
RUN conda install conda-forge::pandas
RUN conda install conda-forge::torchmetrics 
RUN conda install conda-forge::mlxtend