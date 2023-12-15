# ------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All rights reserved.
#  Licensed under the MIT License (MIT). See License in the repo root for license information.
# ------------------------------------------------------------
Param(
    
  [string]
  [Parameter(mandatory = $True)]
  $ResourceGroupName

)

Write-Host "About to delete Azure Resource Group '$ResourceGroupName' - please confirm when prompted, this will take some minutes"

# Delete Azure resources
az group delete --name $ResourceGroupName

Write-Host "Azure resources deleted" -ForegroundColor DarkGreen

k3d registry delete devregistry.localhost  
k3d cluster delete devcluster

Write-Host "K3D registry and cluster deleted"  -ForegroundColor DarkGreen

# Create local registry for K3D and local development
k3d registry create devregistry.localhost  --port 5500

# Create k3d cluster with NFS support and forwarded ports
# See https://github.com/jlian/k3d-nfs
# Note devregistry.localhost needs to be passed into the cluster with the prefix `k3d-`
k3d cluster create devcluster --registry-use k3d-devregistry.localhost:5500 -i ghcr.io/jlian/k3d-nfs:v1.25.3-k3s1 --env 'K3D_FIX_MOUNTS=1@server:*' `
-p '1883:1883@loadbalancer' `
-p '8883:8883@loadbalancer' `
-p '6001:6001@loadbalancer' `
-p '4000:80@loadbalancer'

Write-Host "Installing Dapr on cluster" -foregroundcolor DarkGreen
Start-Sleep -Seconds 15 # wait for cluster to be ready

helm repo add dapr https://dapr.github.io/helm-charts/
helm repo update
helm upgrade --install dapr dapr/dapr --version=1.11 --namespace dapr-system --create-namespace --wait

Write-Host "K3D registry and cluster created again, you can now run through Readme for installation"  -ForegroundColor DarkGreen