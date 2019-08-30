@echo off
IF EXIST pom.xml GOTO POM 
IF EXIST package.json GOTO DOCKER 

echo tekton-basic-pipeline
GOTO END

:POM
echo maven-docker-build-deploy
GOTO END 

:DOCKER
echo maven-docker-build-deploy
GOTO END  

:END



