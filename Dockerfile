FROM ubuntu:16.04

# Install Mecab
RUN apt-get update \
    && apt-get install -y git\
    && apt-get install -y make\
    && apt-get install -y curl\
    && apt-get install -y xz-utils\
    && apt-get install -y file\
    && apt-get install -y sudo\
    && apt-get install -y wget\
    && apt-get install -y software-properties-common 
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update

# Set locale（後々MeCabの実行結果を試しに表示するときに必要だった。dockerコンテナ上でMeCabとか実行する必要ないならいらないかも？）
RUN apt-get install -y locales
RUN locale-gen ja_JP.UTF-8  
ENV LANG ja_JP.UTF-8  
ENV LANGUAGE ja_JP:en  
ENV LC_ALL ja_JP.UTF-8

# Install MySQL
RUN apt-get install -y libmysqlclient-dev

# Install Python
RUN apt-get install -y build-essential python3.6 python3.6-dev python3.6-venv
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python3
RUN pip install pip --upgrade

# Setup application
WORKDIR /var/www/webapp
ADD requirements.txt /var/www/webapp/
RUN pip install -r requirements.txt
ADD . /var/www/webapp/
