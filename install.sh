

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

if [ -z $TEKTON_DEMO_NS ]
then
export TEKTON_DEMO_NS=tekton-pipelines
fi
if [ -z $TEKTON_DEMO_SA ]
then 
export TEKTON_DEMO_SA=tekton-dashboard
fi

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

# latest == uncomment these if you want master releases
TEKTON=$RELEASES/latest/release.yaml
DASH=$RELEASES/dashboard/latest/release.yaml 

YAML=$(mktemp)
curl -s $TEKTON | \
     sed "s/tekton-pipelines/$TEKTON_DEMO_NS/g" | \
     sed "s/tekton-dashboard/$TEKTON_DEMO_SA/g" > $YAML
kubectl apply -f $YAML -n $TEKTON_DEMO_NS

curl -s $DASH | \
     sed "s/tekton-pipelines/$TEKTON_DEMO_NS/g" | \
     sed "s/tekton-dashboard/$TEKTON_DEMO_SA/g" > $YAML
kubectl apply -f $YAML -n $TEKTON_DEMO_NS

export PATH=$PATH:$(pwd)/scripts

#curl -m 2 localhost:9097 | grep Failed > /dev/null
curl -s -m 2 localhost:9097 > /dev/null
if [ $? -eq 0 ] ; then
    echo connect to http://localhost:9097 for tekton dashboard
else 
    echo Running dashboard via port forward in Background
    echo See port-forward-tekton.log for port forwarding information
    
    sh scripts/port-forward-tekton  > port-forward-tekton.log &
    sleep 10
fi 

bash scripts/install-secret

echo "-----------------------"
echo "Tekton Demo Installed "
echo " "
echo "Namespace for Demo: " $TEKTON_DEMO_NS 
echo "ServiceAccount for Demo: " $TEKTON_DEMO_SA

PADD=$(pwd)/scripts
echo "Note:"
echo 1: Add this to your path for scripts to work:  $PADD
echo 2: Connect to http://localhost:9097 for tekton dashboard

