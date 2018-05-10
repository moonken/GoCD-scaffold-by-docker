# Introduction:

this tool is used to setup GoCD quickly.

Before run the go.sh, you need to set some env variables:


| Variable  |  Description | Default Value |
|---|---|---|
| GO\_ADMIN\_PASSWORD  | go admin password  | admin
| GO\_AGENT\_NUMBER  |  the number of go agent | 2
| CREATE\_DOCKER\_MACHINE\_ON\_AWS  | create docker machine on AWS or not, if not, will start GoCD containers on local docker server  | false
 AWS\_ACCESS\_KEY\_ID  | required if CREATE\_DOCKER\_MACHINE\_ON\_AWS = true  |
 AWS\_SECRET\_ACCESS\_KEY  | required if CREATE\_DOCKER\_MACHINE\_ON\_AWS = true  |
 
then, run

`
go.sh
` 

a folder named output will be generated, include all files to start GoCD containers.

you can run 

`
docker-compose -f output/docker-compose.yml up -d --build --scale gocd-agent=$GO_AGENT_NUMBER
`

to start containers directly or goto output folder and change the dockerfile for go agent(usually, we need to install some tools on go agents by change the dockerfile), then start docker containers inside output.

`
cd output
`

`
docker-compose up -d --build --scale gocd-agent=$GO_AGENT_NUMBER
`

GoCD will launch on your docker host's 8153 port.