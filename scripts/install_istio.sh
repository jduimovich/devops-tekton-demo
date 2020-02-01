#!/bin/bash
 
# Installation instructions: https://knative.dev/docs/install/installing-istio/

if [ -z "$1" ]; then
    echo "Usage ERROR need istio version"
    exit 1
fi

export ISTIO_VERSION=$1
if [ -d istio-${ISTIO_VERSION} ]
then
echo Istio  istio-${ISTIO_VERSION} already downloaded. 
else # 
curl -L https://git.io/getLatestIstio | sh -
echo Downloading  istio-${ISTIO_VERSION} .
fi

export PATH="$PATH:/Users/johnduimovich/dev/istio/istio-${ISTIO_VERSION}/bin"
istioctl manifest apply --set profile=demo

