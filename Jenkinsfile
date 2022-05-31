  pipeline {
    
    agent any
    environment {
        AWS_DEFAULT_REGION="eu-west-1"
        PATH="$PATH:$HOME/dctlenv/bin/"
    }

    stages {
        stage("Init") {
            steps {
                sh "terraform init -reconfigure"
            }
        }
        stage('Validate') {
            failFast true
            parallel {
                
                stage("terraform/fmt") {
                    steps {
                        sh "terraform fmt -check -diff"
                    }
                }
                stage("terraform/validate") {
                    steps {
                        sh "terraform validate"
                    }
                }
            }
        }
        stage("Plan") {
            steps {
                sh "terraform plan -out=plan.out"
            }
        }
        stage("Deploy") {
            steps {
                sh "terraform apply -input=false plan.out"
            }
        }
    }
  }
