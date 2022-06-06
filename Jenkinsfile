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

    //   stage(".driftignore") {
    //        steps {
        
    //            sh '''
    //                driftctl scan --from tfstate+s3://this-is-terraform-state/terraform-demo/terraform.tfstate --output json://drifts.json
    //                driftctl gen-driftignore -i drifts.json
    //            '''

    //         }
    //     }
      
        try {
          stage("Store daily reports on S3") {
            steps {
                sh "driftctl scan --quiet --only-managed --from tfstate+s3://this-is-terraform-state/terraform-demo/*.tfstate --output html://driftctl-report-`date '+%Y%m%d%H%M'`.html"
  //                 sh "aws s3 cp driftctl-report-*.html s3://this-is-terraform-state/driftctl-report/"
  //                 s3Upload(file:'driftctl-report-*.html', bucket:'this-is-terraform-state', path:'driftctl-report/driftctl-report-*.html')
            }
          }
        } catch (Exception e) {
              steps {
                echo "Stage failed, but we continue"
              }
             }
    
      
        stage("driftctl") {
            steps {
                sh "driftctl scan --only-managed --from tfstate+s3://this-is-terraform-state/terraform-demo/*.tfstate"
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
