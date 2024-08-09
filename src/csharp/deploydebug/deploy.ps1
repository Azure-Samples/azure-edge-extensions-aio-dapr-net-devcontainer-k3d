# ------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All rights reserved.
#  Licensed under the MIT License (MIT). See License in the repo root for license information.
# ------------------------------------------------------------
param (    
    [Parameter(Mandatory=$False)]
    [string]$ContainerRegistry = "k3d-devregistry.localhost:5500",

    [Parameter(Mandatory=$True)]
    [string]$Version
)

# $contents = (Get-Content $PSScriptRoot/yaml/deployment.yaml) -Replace '__{container_registry}__', $ContainerRegistry
# $contents = $contents -replace '__{image_version}__', $Version

# $contents | kubectl apply -f -

kubectl apply -f $PSScriptRoot/yaml/deployment.yaml
kubectl apply  -f $PSScriptRoot/yaml/pubsubcomponent.yaml