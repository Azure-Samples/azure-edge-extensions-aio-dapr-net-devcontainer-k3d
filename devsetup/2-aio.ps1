# ------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All rights reserved.
#  Licensed under the MIT License (MIT). See License in the repo root for license information.
# ------------------------------------------------------------
Param(
    
  [string]
  [Parameter(mandatory = $True)]
  $ResourceGroupName,

  [string]
  [Parameter(mandatory = $True)]
  $ClusterName,

  [string]
  [Parameter(mandatory = $True)]
  $KeyVaultName

)

Write-Host "Pre-requisite - Key Vault creation"

az keyvault create -n $KeyVaultName -g $ResourceGroupName --enable-rbac-authorization false
$keyVaultResourceId = $(az keyvault show -n $KeyVaultName -g $ResourceGroupName -o tsv --query id)

Write-Host "Deploying AIO components"

az iot ops init --cluster $ClusterName -g $ResourceGroupName --kv-id $keyVaultResourceId `
  --mq-mode auto --simulate-plc

Write-Host "Configuring MQ Broker DNS additional entries and non TLS Listener"  -ForegroundColor DarkGreen
kubectl apply -f $PSScriptRoot/yaml/listener-dns.yaml
kubectl apply -f $PSScriptRoot/yaml/listener-non-tls.yaml

Write-Host "Sample App Infra - `sample-app` namespace, CA trust configmap copy and SA creation"  -ForegroundColor DarkGreen
kubectl create namespace sample-app --dry-run=client -o yaml | kubectl apply -f -
# Copy CA trust configmap to sample-app namespace
kubectl get configmap aio-ca-trust-bundle-test-only -n azure-iot-operations -o yaml | ForEach-Object {$_.replace("namespace: azure-iot-operations","namespace: sample-app")} | kubectl apply -f - 
# Create Service Account
kubectl create sa sample-app-client -n sample-app --dry-run=client -o yaml | kubectl apply -f -

Write-Host "AIO components deployed in Azure and on the K3D cluster in the dev container"  -ForegroundColor DarkGreen