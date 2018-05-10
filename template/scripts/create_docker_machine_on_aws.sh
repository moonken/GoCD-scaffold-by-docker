docker-machine rm $AWS_INSTANCE_NAME -f

docker-machine create \
--driver amazonec2 \
--amazonec2-ami "ami-3d805750" \
--amazonec2-access-key $AWS_ACCESS_KEY_ID \
--amazonec2-secret-key  $AWS_SECRET_ACCESS_KEY \
--amazonec2-region cn-north-1 \
--amazonec2-instance-type "t2.medium" \
--amazonec2-root-size 24 \
--amazonec2-ssh-user centos \
--amazonec2-ssh-keypath ~/.ssh/id_rsa_gocd \
--amazonec2-tags "usage,$USAGE_TAG,env,$ENV_TAG" \
$AWS_INSTANCE_NAME

echo "--------docker machine created------------------"
docker-machine env --shell bash $AWS_INSTANCE_NAME
eval $(docker-machine env --shell bash $AWS_INSTANCE_NAME)

echo "--------backup docker machines---------------"
cp -rf ~/.docker ~/shared/docker-machines
