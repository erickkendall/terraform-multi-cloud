#!/bin/bash

# Define the root directory
ROOT_DIR="terraform-multi-cloud"

# Create the root directory
mkdir -p $ROOT_DIR

# Function to create provider structure
create_provider_structure() {
    local provider=$1
    mkdir -p $ROOT_DIR/$provider/{compute,storage,kubernetes,networking}
    touch $ROOT_DIR/$provider/compute/{ec2,auto_scaling}.tf
    touch $ROOT_DIR/$provider/storage/{s3,ebs}.tf
    touch $ROOT_DIR/$provider/kubernetes/eks.tf
    touch $ROOT_DIR/$provider/networking/{vpc,security_groups}.tf
}

# Create structure for each provider
create_provider_structure "aws"
create_provider_structure "azure"
create_provider_structure "google"

# Rename some files for Azure and Google to match their services
mv $ROOT_DIR/azure/compute/ec2.tf $ROOT_DIR/azure/compute/virtual_machines.tf
mv $ROOT_DIR/azure/compute/auto_scaling.tf $ROOT_DIR/azure/compute/vmss.tf
mv $ROOT_DIR/azure/storage/s3.tf $ROOT_DIR/azure/storage/blob.tf
mv $ROOT_DIR/azure/storage/ebs.tf $ROOT_DIR/azure/storage/disk.tf
mv $ROOT_DIR/azure/kubernetes/eks.tf $ROOT_DIR/azure/kubernetes/aks.tf
mv $ROOT_DIR/azure/networking/security_groups.tf $ROOT_DIR/azure/networking/nsg.tf

mv $ROOT_DIR/google/compute/ec2.tf $ROOT_DIR/google/compute/compute_engine.tf
mv $ROOT_DIR/google/compute/auto_scaling.tf $ROOT_DIR/google/compute/instance_groups.tf
mv $ROOT_DIR/google/storage/s3.tf $ROOT_DIR/google/storage/cloud_storage.tf
mv $ROOT_DIR/google/storage/ebs.tf $ROOT_DIR/google/storage/persistent_disk.tf
mv $ROOT_DIR/google/kubernetes/eks.tf $ROOT_DIR/google/kubernetes/gke.tf
mv $ROOT_DIR/google/networking/security_groups.tf $ROOT_DIR/google/networking/firewall.tf

# Create modules directory
mkdir -p $ROOT_DIR/modules/{aws,azure,google}

# Create environments directory
mkdir -p $ROOT_DIR/environments/{dev,staging,prod}

# Create root level files
touch $ROOT_DIR/{variables,outputs,versions}.tf
touch $ROOT_DIR/README.md

echo "Terraform project structure created in $ROOT_DIR"
