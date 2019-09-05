

@echo off 


 
cd scripts
rem ISTIO 
call install_istio.bat 
rem TEKTON 
call install_knative.bat


set RELEASES=https://storage.googleapis.com/tekton-releases

rem working lineup based on 0.5.2
set TEKTON=%RELEASES%/previous/v0.5.2/release.yaml
set DASH=%RELEASES%/dashboard/previous/v0.1.1/release.yaml
set EXTEND=%RELEASES%/webhooks-extension/previous/v0.1.1/release.yaml

rem latest == uncomment these if you want master releases
rem TEKTON=%RELEASES%/latest/release.yaml
rem DASH=%RELEASES%/dashboard/latest/release.yaml
rem EXTEND=%RELEASES%/webhooks-extension/latest/release.yaml

kubectl apply -f %TEKTON%
kubectl apply -f %DASH%
kubectl apply -f %EXTEND%  
 

start "PORT FORWARD TO DASHBOARD" /MIN port-forward-tekton.bat 
rem background no new window mode if wanted for demos
rem /B port-forward-tekton.bat  >port-forward-tekton.log 

call install-secret.bat

cd ..

@echo -----------------------
@echo Tekton Demo Installed 
@echo Note on windows, the secrets need to be installed via the dashboard

@echo "Namespace for Demo: " %TEKTON_DEMO_NS%  
@echo "ServiceAccount for Demo: " %TEKTON_DEMO_SA%  

echo connect to http://localhost:9097 for tekton dashboard

