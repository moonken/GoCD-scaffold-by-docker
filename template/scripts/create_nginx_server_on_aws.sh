PATH=~/.local/bin:$PATH

function getPublicIpAddress {
    aws ec2 describe-instances --filters "Name=tag:Name,Values=$AWS_INSTANCE_NAME" | python -c 'import sys, json; result = json.load(sys.stdin); print list(filter(lambda x: "PublicIpAddress" in x["Instances"][0],result["Reservations"]))[0]["Instances"][0]["PublicIpAddress"]'
}

aws ec2 describe-key-pairs --key-name gocd
if [ $? != 0 ]; then
    aws ec2 import-key-pair --key-name gocd --public-key-material "file:///home/go/.ssh/id_rsa_gocd.pub"
fi

aws ec2 describe-security-groups --group-names http-80-with-ssh
if [ $? != 0 ]; then
    aws ec2 create-security-group --group-name http-80-with-ssh --description http-80-with-ssh
    aws ec2 authorize-security-group-ingress --group-name http-80-with-ssh --protocol tcp --port 80 --cidr 0.0.0.0/0
    aws ec2 authorize-security-group-ingress --group-name http-80-with-ssh --protocol tcp --port 22 --cidr 0.0.0.0/0
fi

publicIp=$(getPublicIpAddress)
if [ $? != 0 ]; then
    securityGroupId=$(aws ec2 describe-security-groups --group-names http-80-with-ssh | python -c 'import sys, json; result = json.load(sys.stdin); print str(result["SecurityGroups"][0]["GroupId"])')
    aws ec2 run-instances --image-id ami-d58658b8 --security-group-ids $securityGroupId --key-name gocd --block-device-mappings "[{\"DeviceName\": \"/dev/sda1\",\"Ebs\":{\"VolumeSize\":500}}]" --instance-type $AWS_INSTANCE_TYPE --count 1 --associate-public-ip-address --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$AWS_INSTANCE_NAME}, {Key=usage,Value=$USAGE_TAG}, {Key=env,Value=$ENV_TAG}]"
fi


