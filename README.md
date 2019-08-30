# devops-tekton-demo

A basic Tekton Demo


#Pre-Install

You will need `kubectl`, `helm`, `curl` and `tar` utilities on your path .

#Install 

This will run install tekton and dependencies and initialize all the default pipelines in your system


## OS X

Tekton and dependencies 

``` sh install.sh```

Run install of pipelines via a pipeline0 run.

``` sh scripts/run-p0 ```

## Windows 

Tekton and dependencies 

```install.bat```

You need to install tekton resources from https://github.com/jduimovich/devops-tekton-demo.git to get the pipelines for now.
Automated p0 install will be coming soon.
For manual install of pipelines use this git repo 
`https://github.com/jduimovich/devops-tekton-demo.git`
select `tekton-pipelines` namespace and `pipelines` as the install directory and the `tekton-dashboard` service account.

# Dashboard

The   dashboard will be at localhost:9097  

Run the pipelined named "tekton-basic-pipeline" from the UI. 
Select the tekton-dashboard service account.


