#!/usr/bin/env bash
##!/bin/bash
function check_env {
    if [[ -z "${GO_ADMIN_PASSWORD}" ]]; then
        echo "set GO_ADMIN_PASSWORD to admin as default";
        GO_ADMIN_PASSWORD=admin
    fi

    if [[ -z "${GO_AGENT_NUMBER}" ]]; then
        echo "set GO_AGENT_NUMBER to 2 as default";
        GO_AGENT_NUMBER=2
    fi
}

function gen_ssh_key_for_gocd {
    echo -e  'y' | ssh-keygen -b 2048 -t rsa -f output/.ssh/id_rsa_gocd -q -N ""
    cp -rf output/.ssh output/goagent/.ssh
    cp -rf output/.ssh output/goserver/.ssh
    echo "use below key as deploy key for GoCD"
    cat output/.ssh/id_rsa_gocd.pub
}

function create_docker_machine {
    if [ "$CREATE_DOCKER_MACHINE_ON_AWS" = "true" ]; then
        if [[ -z "${AWS_ACCESS_KEY_ID}" ]] || [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
            echo "AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are not set, use local docker";
        else
            docker-machine create \
            --driver amazonec2 \
            --amazonec2-ami "ami-3d805750" \
            --amazonec2-access-key $AWS_ACCESS_KEY_ID \
            --amazonec2-secret-key  $AWS_SECRET_ACCESS_KEY \
            --amazonec2-region cn-north-1 \
            --amazonec2-instance-type "t2.medium" \
            --amazonec2-root-size 32 \
            --amazonec2-ssh-user centos \
            --amazonec2-ssh-keypath output/.ssh/id_rsa_gocd \
            --amazonec2-tags "usage,dev" \
            gocd
            eval $(docker-machine env gocd)
        fi
    fi
}

function gen_passwd_file_for_gocd {
    htpasswd -b -s -c output/goserver/passwd admin $GO_ADMIN_PASSWORD
}

#############################################################
CWD="$(dirname "$0")"
DIR="$(cd "$CWD" && pwd)"

if [ -d "output" ]; then
  mv output output.$(date +%s).bak
fi

mkdir output
cp -r template/. output

check_env
gen_passwd_file_for_gocd
gen_ssh_key_for_gocd
create_docker_machine



