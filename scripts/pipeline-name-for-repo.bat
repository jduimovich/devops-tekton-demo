@echo off
IF EXIST tekton-pipeline-name GOTO TEKTON  
IF EXIST pom.xml GOTO POM 
IF EXIST package.json GOTO DOCKER 

echo tekton-basic-pipeline
GOTO END

:POM
echo maven-docker-build-deploy
GOTO END 

:DOCKER
echo docker-build-deploy
GOTO END  

:TEKTON
type tekton-pipeline-name
GOTO END   

:END
