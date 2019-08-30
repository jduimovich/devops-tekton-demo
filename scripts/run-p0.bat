 @echo off
 
set script_dir=%~dp0
@echo running in script_dir:  %script_dir%
 

FOR /F "tokens=* USEBACKQ" %%F IN (`%script_dir%git-repo-url.bat`) DO (SET git-repo-url=%%F)
ECHO Repository is: %git-repo-url%
FOR /F "tokens=* USEBACKQ" %%F IN (`%script_dir%pipeline-name-for-repo.bat`) DO (SET pipeline-name-for-repo=%%F)
ECHO Pipeline is:  %pipeline-name-for-repo%

%script_dir%run-p0-pipeline.bat %git-repo-url% 


 