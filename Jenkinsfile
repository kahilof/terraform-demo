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

        stage(".driftignore") {
             steps {
        
                //sh "driftctl scan --from tfstate+s3://this-is-terraform-state/terraform-demo/terraform.tfstate --output json://drifts.json"
                
                //sh "driftctl gen-driftignore -i drifts.json > .driftignore"

              }
         }
      
        stage("driftctl") {
            steps {
          //      sh "driftctl scan --from tfstate+s3://this-is-terraform-state/terraform-demo/terraform.tfstate --output json://drifts.json"
          //      sh "driftctl gen-driftignore -i drifts.json > .driftignore"
                sh "driftctl scan --from tfstate+s3://this-is-terraform-state/terraform-demo/*.tfstate"
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
