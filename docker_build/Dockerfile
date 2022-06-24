FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG GIT_TOKEN

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install \
        software-properties-common \
        curl \
        unzip \
        bash \
        python3-pip \        
        git \
        jq \
        zsh

# Copy & Install the dependencies file to the working directory
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

COPY ./scripts /root/docker_build/scripts
ENV PATH=$PATH:/root/docker_build/scripts/fast_goblet:/root/docker_build/scripts/fast_dbt