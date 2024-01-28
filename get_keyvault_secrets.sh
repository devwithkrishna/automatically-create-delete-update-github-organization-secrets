#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <KeyVaultName> <SecretName>"
    exit 1
fi

keyvault_name=$1
secret_name=$2

# Check if the secret exists in the Key Vault
az keyvault secret show --vault-name "$keyvault_name" --name "$secret_name" --query "name" --output tsv > /dev/null 2>&1

# Check the exit code of the previous command
if [ $? -ne 0 ]; then
    echo "Secret '$secret_name' does not exist in Key Vault '$keyvault_name'. Exiting."
    exit 1
fi

# Fetch Key Vault secret
secret_value=$(az keyvault secret show --vault-name "$keyvault_name" --name "$secret_name" --query "value" --output tsv)

# Set SECRET environment variable
export SECRET="$secret_value"

# Check if the secret was retrieved successfully
if [ -n "$secret_value" ]; then
    echo "Secret '$secret_name' from Key Vault '$keyvault_name': $secret_value"
else
    echo "Failed to retrieve secret '$secret_name' from Key Vault '$keyvault_name'."
fi


