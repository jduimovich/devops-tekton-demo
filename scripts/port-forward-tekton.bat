 

FOR /F "tokens=*" %%a in ('tekton-dash-pod.bat') do SET POD=%%a
echo %POD%
kubectl port-forward  %POD% -n  %TEKTON_DEMO_NS%   9097:9097
 

