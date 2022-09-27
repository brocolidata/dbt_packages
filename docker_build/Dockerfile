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
        zsh \
        apt-transport-https \
        ca-certificates \
        gnupg

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && apt-get update -y \
    && apt-get install google-cloud-cli -y
      

# Copy & Install the dependencies file to the working directory
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

## Setup nodejs (debug npx semantic-release)
# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
#     && apt-get -y update \
#     && apt-get -y install nodejs

COPY ./scripts /root/docker_build/scripts
ENV PATH=$PATH:/root/docker_build/scripts/fast_goblet:/root/docker_build/scripts/fast_dbt