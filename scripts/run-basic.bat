 
 @echo off
 
set script_dir=%~dp0


FOR /F "tokens=* USEBACKQ" %%F IN (`%script_dir%git-repo-url.bat`) DO (SET git-repo-url=%%F)
ECHO Repository is: %git-repo-url%
FOR /F "tokens=* USEBACKQ" %%F IN (`%script_dir%pipeline-name-for-repo.bat`) DO (SET pipeline-name-for-repo=%%F)
ECHO Pipeline is:  %pipeline-name-for-repo%

%script_dir%run-basic-pipeline.bat %git-repo-url%  %pipeline-name-for-repo% 