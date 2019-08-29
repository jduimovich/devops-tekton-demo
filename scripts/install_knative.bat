 
  set version=v0.6.0
 
  kubectl apply --filename https://github.com/knative/serving/releases/download/%version%/serving.yaml

  kubectl apply --filename https://github.com/knative/eventing/releases/download/%version%/release.yaml

  kubectl apply --filename https://github.com/knative/eventing-sources/releases/download/%version%/eventing-sources.yaml
 
 

 
 