# ------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All rights reserved.
#  Licensed under the MIT License (MIT). See License in the repo root for license information.
# ------------------------------------------------------------
Param(
    
  [string]
  [Parameter(mandatory = $True)]
  $ResourceGroupName,

  [string]
  [Parameter(mandatory = $False)]
  $ClusterName = "arck-aio-dev",

  [string]
  [Parameter(mandatory = $False)]
  $Location = "northeurope"

)

Write-Host "Registering providers"

az provider register -n "Microsoft.ExtendedLocation"
az provider register -n "Microsoft.Kubernetes"
az provider register -n "Microsoft.KubernetesConfiguration"
az provider register -n "Microsoft.IoTOperationsOrchestrator"
az provider register -n "Microsoft.IoTOperations"
az provider register -n "Microsoft.DeviceRegistry"

Write-Host "Creating Resource Group and Connecting K3S Cluster to Azure Arc"

az group create --name $ResourceGroupName --location $Location

az connectedk8s connect --name $ClusterName `
    --resource-group $ResourceGroupName `
    --location $Location

$arcObjectId = $(az ad sp show --id bc313c14-388c-4e7d-a58e-70017303ee3b --query id -o tsv)

az connectedk8s enable-features -n $ClusterName -g $ResourceGroupName --custom-locations-oid $arcObjectId --features cluster-connect custom-locations

Write-Host "Resource Group '$ResourceGroupName' created and K3S Cluster named '$ClusterName' connected to Azure Arc"  -ForegroundColor DarkGreen