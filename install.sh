

verify_env () {
name=$1
val=${!name}
if [ -z $val ]
then
echo "\n" No $1 set, please set to your token to use this script
ERROR=1
else 
if [ $2. == "secret." ]
then
echo $name "= (secret - hidden)"
else
echo $name "= $val"
fi
fi

}

export TEKTON_DEMO_NS=tekton-pipelines
export TEKTON_DEMO_SA=tekton-dashboard

verify_env "TEKTON_DEMO_NS"
verify_env "TEKTON_DEMO_SA"

verify_env "MY_PUBLIC_GIT_USER" 
verify_env "MY_PUBLIC_GIT_TOKEN"  secret

verify_env "MY_DOCKER_USER" 
verify_env "MY_DOCKER_PW"  secret 

if [ -z $ERROR ]
then
echo $0 "Environment Variables OK"
else
echo $0 "Some Environment Variables Missing, see log."
exit 
fi


# ISTIO
kubectl get pods -n istio-system | grep istio > /dev/null
if [ $? -eq 0 ] ; then
    echo  "istio-system  already installed"
else  
    (cd scripts; sh ./install_istio.sh 1.2.2)
fi

# KNATIVE 
kubectl get namespaces | grep knative > /dev/null
if [ $? -eq 0 ] ; then
    echo  "knative already installed"
else 
    (cd scripts; sh ./install_knative.sh v0.6.0)
fi

# TEKTON 

RELEASES=https://storage.googleapis.com/tekton-releases

# working lineup based on 0.5.2
TEKTON=$RELEASES/previous/v0.5.2/release.yaml
DASH=$RELEASES/dashboard/previous/v0.1.1/release.yaml
EXTEND=$RELEASES/webhooks-extension/previous/v0.1.1/release.yaml

# latest == uncomment these if you want master releases
#TEKTON=$RELEASES/latest/release.yaml
#DASH=$RELEASES/dashboard/latest/release.yaml
#EXTEND=$RELEASES/webhooks-extension/latest/release.yaml

kubectl apply -f $TEKTON
kubectl apply -f $DASH 
kubectl apply -f $EXTEND 

export PATH=$PATH:$(pwd)/scripts

#curl -m 2 localhost:9097 | grep Failed > /dev/null
curl -s -m 2 localhost:9097 > /dev/null
if [ $? -eq 0 ] ; then
    echo connect to http://localhost:9097 for tekton dashboard
else 
    echo Running dashboard via port forward in Background
    echo See port-forward-tekton.log for port forwarding information
    
    sh scripts/port-forward-tekton  > port-forward-tekton.log &
    sleep 3
fi 

sh scripts/install-secret

echo "-----------------------"
echo "Tekton Demo Installed "
echo " "

echo connect to http://localhost:9097 for tekton dashboard

