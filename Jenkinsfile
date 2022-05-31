  pipeline {
    agent {
      node {
        label "aws"
      }
    }
    }

    stages {
        stage("Init") {
            steps {
                sh "terraform init"
            }
        }
        stage('Validate') {
            failFast true
            parallel {
                stage("driftctl") {
                    steps {
                        sh "which dctlenv || git clone https://github.com/wbeuil/dctlenv"
                        sh "dctlenv use latest"
                        sh "driftctl scan"
                    }
                }
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
