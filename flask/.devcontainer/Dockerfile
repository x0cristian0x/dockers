FROM python:3.9.18-alpine3.19

COPY ./../requirements.txt ./requirements.txt

RUN pip install --upgrade pip
RUN pip install -r requirements.txt


#COPY ./srv ./srv
#ENV FLASK_APP=app
#CMD ["python","app.py"]