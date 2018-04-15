#!/bin/bash

# get ip address of instance, then we can use the private key in this directory
# and run inspec against the instance
instanceIP=`egrep -o '([1-9][0-9]{0,2})(\.([0-9]{0,3})){3}' ./logs/build.log`
if [[ -n "$instanceIP" ]] ; then
  echo "Running inspec tests:"
  inspec detect -i ./files/ssh_key_packer_inspec --sudo -t ssh://ec2-user@${instanceIP}
  if [[ $? -ne "0" ]] ; then exit 1 ; fi
else
  echo "Unable to determine instance IP - exiting!"
  exit 1
fi
if [[ -f ./logs/build.log ]] ; then rm ./logs/build.log ; fi
