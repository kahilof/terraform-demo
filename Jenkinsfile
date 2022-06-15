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
      
//         stage("Destroy") {
//             steps {
//                 sh "terraform destroy -auto-approve"
//             }
//         }
      
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

        stage("driftctl") {
            steps {
                sh "driftctl scan --only-managed --from tfstate+s3://this-is-terraform-state/terraform-demo/*.tfstate"
                sh "driftctl scan --only-managed --from tfstate+s3://terraform-demo-ec2/terraform-demo/*.tfstate"
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
