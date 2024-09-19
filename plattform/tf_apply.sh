#!/bin/sh
clear

terraform fmt -recursive . &&
tflint --recursive --minimum-failure-severity=error &&
terraform init &&
terraform apply
