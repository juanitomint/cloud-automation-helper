# Dev Ops Cloud Automation
Set of scripts to help docker build and deploy in Cloud environments



### Step 1 initialize git submodules in your project
```
git submodule init 
```

### Step2 add this repo as a git submodule choose a branch from below
Los tipos de proyectos disponibles son:
* amplify
* docker
* ecs
* ecs-rolling
* elastic-beanstalk

ie:
```
git submodule add -f -b amplify https://bitbucket.personal.corp:8443/scm/doc/automation.git
```
esto creará la carpeta automation dentro del repositrio con todos los scripts necesarios
### Step3  create an environments.json
Set the the variables according to the environments.
Variables will be exported at run-time 
Exported variables can override other settings too

```
cp automation/environments.json ./
```

In this scheme each branch has a configuration
when using ./automation/read_config.sh in scripts
defined values are exported to the execution scope of the script

For example, if we are in the "test" branch, the invocation of the file ./automation/read_config.sh all of the test.xxx keys wil be exported as variable=value
```json
$ source ./automation/read_config.sh 

Reading CONFIG: master FROM environments.json
{
  "target": "Production",
  "skip_ci": true,
  "Author": "Juan Ignacio Borda",
  "TARGET_AWS_ACCOUNT": "XXXXXXXXXXXX",
  "TARGET_AWS_ROLE": "devops-deploy-role",
  "TARGET_REGION": "us-east-1"

}

$ echo $target 
Production
```



### Requirements 
* git >2
* bash >4



#TODO implement default config for environments Pull requests, Merge Requests and auxiliary topic branches

