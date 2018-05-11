# Introduction:

this tool is used to setup GoCD quickly.

## Feature
1. Fast setup a GoCD by simple command:

   ```shell
   go.sh
   docker-compose -f output/docker-compose.yml up -d --build --scale gocd-agent=2
   ```
2. Go agents could share files by a shared columes

   A agent could put share file to /home/go/shared folder, then other could access     them in their own path '/home/go/shared', it is useful in some scenarios.
   
3. Support customlize Go agent dockerfile(manually)

4. Provided a simple [Pipeline As Code example](https://github.com/moonken/GoCD-Pipeline-As-Code-Yaml). 

## Dependencies
* docker server(local or remote, this tool support create a docker machine on AWS)
* docker-compose
* docker-machine
* curl

## Instructions

Before run the go.sh, you need to set some env variables:


| Variable  |  Description | Default Value |
|---|---|---|
| GO\_ADMIN\_PASSWORD  | go admin password  | admin
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
docker-compose -f output/docker-compose.yml up -d --build --scale gocd-agent=2
`

to start containers directly or goto output folder and change the dockerfile for go agent(usually, we need to install some tools on go agents by change the dockerfile), then start docker containers inside output.

`
cd output
`

`
docker-compose up -d --build --scale gocd-agent=2
`

GoCD will launch on your docker host's 8153 port.


## FAQ
1. Can not find command when execute job on go agent, for example: can not execute "bash -c 'npm -v'" even you isntalled nodejs on the agent.

   The reason is that go agent runs under a isolation env, it does not load the right PATH variable of user 'go', the solution is to add '-l' as the parameter of bash command, The '-l' forces bash to behave as a login shell, and read the .bashrc/.bash_profile files, refer to [stackoverflow](https://stackoverflow.com/questions/47434160/setting-an-env-variable-accessible-to-the-gocd-pipeline  )