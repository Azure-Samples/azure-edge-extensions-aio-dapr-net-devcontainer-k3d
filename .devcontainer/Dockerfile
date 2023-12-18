# This sample Dockerfile is based on the following sample: https://github.com/Azure-Samples/explore-iot-operations
FROM mcr.microsoft.com/devcontainers/universal:2-linux

# Install mosquitto client
RUN apt-get update && apt-get install mosquitto-clients -y

# Install NSS-myhostname for resolving hostnames
RUN apt-get update && sudo apt-get install libnss-myhostname -y

# Install mqttui
RUN wget https://github.com/EdJoPaTo/mqttui/releases/download/v0.19.0/mqttui-v0.19.0-x86_64-unknown-linux-gnu.deb && \
    sudo apt-get install ./mqttui-v0.19.0-x86_64-unknown-linux-gnu.deb && \
    rm -rf ./mqttui-v0.19.0-x86_64-unknown-linux-gnu.deb
