curl -L "https://github.com/istio/istio/releases/download/1.2.2/istio-1.2.2-linux.tar.gz" --output istio-1.2.2-linux.tar.gz

tar xzf istio-1.2.2-linux.tar.gz

kubectl apply -f istio-ns.yaml

cd istio-1.2.2
kubectl apply -f install/kubernetes/helm/istio-init/files 
 
 
helm template --namespace=istio-system  --set prometheus.enabled=false --set mixer.enabled=false --set mixer.policy.enabled=false --set mixer.telemetry.enabled=false  --set pilot.sidecar=false --set galley.enabled=false --set global.useMCP=false --set security.enabled=false --set global.disablePolicyChecks=true --set sidecarInjectorWebhook.enabled=false --set global.proxy.autoInject=disabled --set global.omitSidecarInjectorConfigMap=true --set gateways.istio-ingressgateway.autoscaleMin=1 --set gateways.istio-ingressgateway.autoscaleMax=1 --set pilot.traceSampling=100 install/kubernetes/helm/istio > ./istio-lean.yaml


kubectl apply -f istio-lean.yaml