#!/usr/bin/env bash

while ! nc -vz 127.0.0.1 8153; do

    echo "go server not start" >> /var/a.txt
    sleep 5s

    if [ -f "/godata/config/cruise-config.xml" ]; then
        CONTENT='> <security><authConfigs><authConfig id="auth" pluginId="cd.go.authentication.passwordfile"><property><key>PasswordFilePath</key><value>/go-server/passwd</value></property></authConfig></authConfigs></security> </server>
        <config-repos><config-repo pluginId="yaml.config.plugin" id="repo1"><git url="https://github.com/moonken/GoCD-Pipeline-As-Code-Yaml.git" /></config-repo></config-repos>'
        C=$(echo $CONTENT | sed 's/\//\\\//g')
        sed -i "s/\/>/$C/g" /godata/config/cruise-config.xml
        break
    fi

done &





