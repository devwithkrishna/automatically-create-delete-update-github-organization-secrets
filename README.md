# automatically-create-delete-update-github-organization-secrets
create , delete or update github organization secrets using github workflow

# Pre requesites
* This requires an authorization method which has organization-secret with write permission
* Personal Access Token (PAT) is the recommended way to authenticate. In this demo PAT is USED.
* You can generate a new one from Github settings
* You need to encrypt a secret before you can create or update secrets.


# How code works for create or update secret


* First this will execute the `get_public_key.sh` shell script to get the Organization public key 
    *  This public key is required and used for encryption of secret

    `Reference`: [get-an-organization-public-key](https://docs.github.com/en/rest/actions/secrets?apiVersion=2022-11-28#get-an-organization-public-key)

* Then it will execute the `get_public_key_id.sh`  script to get the organization key id. 
    * This is required for creation or updation of secret

* Then the `python program` `encrypt_using_libnacl` this uses the public key from step 1 and encrypts the secret 
using the prefered method by GitHub.

    `Reference`: [create-or-update-an-organization-secret](https://docs.github.com/en/rest/actions/secrets?apiVersion=2022-11-28#create-or-update-an-organization-secret)

    - Reference used for encryption : [example-encrypting-a-secret-using-python](https://docs.github.com/en/rest/guides/encrypting-secrets-for-the-rest-api?apiVersion=2022-11-28#example-encrypting-a-secret-using-python )

* Then `Python program` `create_or_update_github_org_secret` is used to take the public key id from step 2 and encrypted secret value from step 3 to create or update the secret.

| status code | operation |
|-------------|-----------|
| 201  | Create Org secret|
| 204  | Update an Org secret |


- visibility of organization secret has been set to all organization repositories. selected means only the repositories specified by selected_repository_ids can access the secret.
- Can be one of: `all`, `private`, `selected`


## Inputs of workflow

| input name | description|
|------------|------------|
| organization | name of github organization |
| secret_name | organization Secret name |
| secret_value | Secret value |


# # How code works for deleting an organization secret

* This runs the shell script `delete_github_org_secret.sh` which takes 2 inputs from github workflow 
1. organization name
2. secret name

* Then deletes the secret

| input | description| 
|-------|--------------|
| organization | GitHub Organization name |
| secret_name | Secert to be deleted |
 