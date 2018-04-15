# Packer + Inspec
[Packer](https://www.packer.io) workflow integrating [Inspec](https://www.inspec.io) testing

## About
This work is is test bed to improve our Amazon Linux AMI build workflow

## Usage
Example usage:
Validate Template
`make validate SUBNETID=subnet-123456ab`

Build AMI
`make build-ami SUBNETID=subnet-123456ab`

Validate & Build
`make all SUBNETID=subnet-123456ab`

Cleanup
`make clean`

## Notes
`ssh_private_key_file` does not appear to work as documented hence it need's to
be used with `ssh_keypair_name` and the keypair needs to be present on AWS.
