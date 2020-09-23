pipeline {
    agent {
        label {
            label "docker"
            //customWorkspace "/bitnami/jenkins/jenkins_home/jobs/ElasticBeanstalk_Pipeline/workspace_ebs/" 
        }
    }
    environment {
        
        REGISTRY = "890209685694.dkr.ecr.us-east-1.amazonaws.com"

    }

    stages {
        
        stage('docker_getenv') {
            steps {
                sh 'rm automation -rf;ln -s ./ ./automation'
                sh './automation/docker_getenv.sh'
                sh 'env'
                
            }
        }

        stage('docker_getenv-docker') {
            agent {
                docker {
                    label 'docker'
                    image 'node:erbium-alpine'
                    args '-u root:root'
                }           
            }
            steps {
                sh 'apk add bash git jq util-linux --update'
                sh 'rm automation -rf;ln -s ./ ./automation'
                sh './automation/docker_getenv.sh'
                sh 'env'
                
            }
        }

    } //--end stages

    // CLEAN WORKSPACES
    post { 
        always { 
            cleanWs()
        }
    }
}