# Azure Edge Extensions AIO - Inner Developer Loop: MQ Dapr Pluggable Component .NET Sample

This sample contains the setup of an inner developer loop to work with Azure IoT Operations (AIO) and custom application using Dapr and .NET.
The repo is using a configuration with Visual Studio Code, Dev Container and VS Code Kubernetes Tools to allow local developer environment configuration and remote debugging of workloads.
The sample workload is using .NET, though the same debugging experience can be achieved with other languages.

> Note: [Azure IoT Operations](https://learn.microsoft.com/en-us/azure/iot-operations/) is currently in PREVIEW and subject to change. This sample might stop working at any time due to changes in the PREVIEW.

## Features

This project framework provides the following features:

* A Visual Studio Dev Container with all the required developer tools and Visual Studio extensions (.NET, PowerShell, Azure CLI, K9s, MQTTUI, Mosquitto client tools)
* Dev Container is initialized with K3D Kubernetes cluster, a local K3D container registry, and pre-installed Dapr on the cluster
* Script for Azure Arc enabling the local cluster
* Script for deploying Azure IoT Operations
* Sample .NET application leveraging Dapr PubSub Pluggable component to subscribe and publish
* Scripts to build and deploy the custom application into the cluster
* Sample deployment of custom workload and cross namespace TLS validation to AIO MQ
* Scripts to reset the dev container K3D cluster to a clean state and delete the related Azure resources

## Getting Started

### Prerequisites

* Visual Studio Code
* Docker
* [Dev container support in Visual Studio Code](https://code.visualstudio.com/docs/devcontainers/tutorial)
* Azure account with permissions to provision new resources, query the Azure Resource Graph and create Service Principals

### Installation

1. Clone this repository on your local machine
2. `cd azure-edge-extensions-aio-dapr-net-devcontainer-k3d`
3. Open the project in Visual Studio Code `code .`
4. Open the Command palette in Visual Studio Code
5. Choose the option `Dev Containers: Reopen in container`
6. Once the setup has been initialized, the dev container will have initialized K3D Kubernetes cluster with a local container registry for development purposes, and Dapr pre-installed. This is now ready for initializing Azure IoT Operations and Azure Arc. The container registry is available inside the dev container and inside the K3D cluster under the name `k3d-devregistry.localhost:5500`.

### Quickstart: Deploying up Azure IoT Operations

* Login into Azure `az login`
* ...

## Demo

A demo app is included to show how to use the project.

To run the demo, follow these steps:

(Add steps to start up the demo)

1.
2.
3.

## Resources

(Any additional resources or related projects)

- Link to supporting information
- Link to similar sample
- ...
