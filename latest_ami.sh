#!/bin/bash
# Find lastest AMI from a name
#
while [ "${@+defined}" ]; do
  case "$1" in
    -name) shift
      image_name=${1} ;;
    *) (>&2 echo 'Invalid parameters for `basename $0` [-name <ami name>)')
      exit 1;;
  esac
  shift
done

filters="Name=virtualization-type,Values=hvm \
 Name=name,Values=${image_name} \
 Name=root-device-type,Values=ebs \
 Name=architecture,Values=x86_64 \
 Name=state,Values=available \
 Name=root-device-type,Values=ebs \
 Name=hypervisor,Values=xen \
 Name=image-type,Values=machine"


source_ami=`aws ec2 describe-images --owners amazon \
    --filters ${filters} \
    --query 'Images[*].[ImageId,ImageLocation,CreationDate]' \
    --output text | sort -k3,3 | tail -1 | awk '{print $1}'`
echo ${source_ami}
