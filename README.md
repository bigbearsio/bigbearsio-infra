# Bigbears.IO Infrastructure

bigbears.io infrastructre as a code.

## Prerequisite
* Terraform `brew install terraform`
* SOPS `brew install sops`
* Terraform SOPS plugin
```
$ mkdir -p ~/.terraform.d/plugins
$ curl -L -o ~/.terraform.d/plugins/terraform-provider-sops_v0.5.0_darwin_amd64.zip \
"https://github.com/carlpett/terraform-provider-sops/releases/download/v0.5.0/terraform-provider-sops_v0.5.0_darwin_amd64.zip"

$ unzip ~/.terraform.d/plugins/terraform-provider-sops_v0.5.0_darwin_amd64.zip \
-d ~/.terraform.d/plugins
```
* Make sure you are part of `bigbears-io` project admin. Then do application-default auth 
```
gcloud auth application-default login
```
* Get auth for Kubernetes cluster in `~/.kube/config`
```
gcloud --project bigbears-io container clusters get-credentials bigbears-cluster  --zone asia-southeast1-b

# The cluster config should show up in kubectl
kubectl config get-contexts
```

## Notes
gcloud commands
```
$ brew cask install google-cloud-sdk
$ gcloud auth login
$ gcloud --project bigbears-io alpha cloud-shell ssh
```

Creating terraform state bucket
```
$ gsutil mb -p bigbears-io -c standard -l asia-southeast1 gs://bigbearsio-tfstate
$ gsutil versioning set on gs://bigbearsio-tfstate
```

