# Makefile
COMMITID=$(shell git rev-parse HEAD)
SOURCEAMI=$(shell ./latest_ami.sh -name aws-elasticbeanstalk-amzn-*ruby*)

SUBNETID =

all : validate build-ami
.PHONY : all

validate:
	packer validate -var 'commit_id=$(COMMITID)' \
	  -var 'source_ami=${SOURCEAMI}' \
		-var 'subnet_id=${SUBNETID}' \
		./templates/packer.json

build-ami:
	packer build -var 'commit_id=$(COMMITID)' \
	  -var 'source_ami=${SOURCEAMI}' \
		-var 'aws_access_key=${AWS_ACCESS_KEY}' \
		-var 'aws_secret_key=${AWS_SECRET_KEY}' \
		-var 'subnet_id=${SUBNETID}' \
		./templates/packer.json | tee ./logs/build.log

clean:
	$(RM) ./logs/build.log
