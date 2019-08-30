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


Run install of pipelines via a pipeline0 run.

``` scripts\run-p0.bat ```
 
 Run a basic pipeline 

``` scripts\run-basic.bat ```

For manual run of the pipelines use the dashboard
# Dashboard

The   dashboard will be at localhost:9097  

Run the pipelined named "tekton-basic-pipeline" from the UI. 
Select the tekton-dashboard service account.


