# ------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All rights reserved.
#  Licensed under the MIT License (MIT). See License in the repo root for license information.
# ------------------------------------------------------------
param (
    [Parameter(Mandatory=$True)]
    [string]$Version,

    [Parameter(Mandatory=$False)]
    [string]$ContainerRegistry = "k3d-devregistry.localhost:5500"
)

docker build $PSScriptRoot/../SamplePubSub/. -f $PSScriptRoot/../SamplePubSub/dev.Dockerfile -t samplepubsub:$Version

docker tag samplepubsub:$Version $ContainerRegistry/samplepubsub:$Version

docker push $ContainerRegistry/samplepubsub:$Version
