
 @echo off

set script_dir=%~dp0
set script_name=%~n0

For /f "tokens=1-2 delims=/ " %%a in ('%script_dir%bash-time.bat') do (set TAG=%%a)
 
set GIT_URL=%1
FOR %%i IN ("%GIT_URL%") DO (set GIT_REPO_BASE=%%~ni)
set DOCKER_IMAGE=%MY_DOCKER_USER%/%GIT_REPO_BASE%:%TAG%
set GIT_SRC_RES=webhook-git-source-%GIT_REPO_BASE%
set IMAGE_REF=webhook-image-ref-%GIT_REPO_BASE%
set PIPELINE_RUN=pr.tmp
set P_REF=%2
set INPUT_TEMPLATE=%script_dir%basic-pipeline-run


echo Pipeline Name: %P_REF%
echo Repository:  %GIT_URL%
echo Service Account: %TEKTON_DEMO_SA%
echo Namespace: %TEKTON_DEMO_NS%

sed  "s!PRUN_NAME! %script_name%-%TAG%!;s!P_SA! %TEKTON_DEMO_SA%!;s!P_REF!%P_REF%!;s!GIT_URL!%GIT_URL%!;s!DOCKER_IMAGE!%DOCKER_IMAGE%!;s!GIT_SRC_RES! %GIT_SRC_RES%!;s!PIPE_DIR! %PIPE_DIR%!;s!TARGET_NS!%TEKTON_DEMO_NS%!;s!IMAGE_REF!%IMAGE_REF%!" <%INPUT_TEMPLATE% > %PIPELINE_RUN%  

kubectl apply -f %PIPELINE_RUN% -n %TEKTON_DEMO_NS%
 

:END


