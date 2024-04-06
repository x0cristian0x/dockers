FROM tensorflow/tensorflow:2.14.0-gpu

RUN pip install ipykernel

# tensorflow-probability==0.22.1 xq no tengo la tf version = 2.15
RUN pip install tensorflow-probability==0.22.1
RUN pip install matplotlib
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install tensorflow-hub
RUN pip install opencv-contrib-python 
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y 
RUN pip install datasets
RUN pip install dlib
RUN pip install --ignore-installed mlflow
RUN pip install plotly seaborn
RUN pip install nbformat
RUN pip install xgboost graphviz lightgbm xgboost lightgbm
RUN apt-get update && apt-get install graphviz -y
