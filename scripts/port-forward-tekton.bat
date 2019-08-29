 
@echo off 

FOR /F "tokens=*" %%a in ('tekton-dash-pod.bat') do SET POD=%%a
echo %POD%

echo Running port forwarding to dashboard
echo open http://localhost:9097/ for dashboard

kubectl port-forward  %POD% -n  %TEKTON_DEMO_NS%   9097:9097
 

