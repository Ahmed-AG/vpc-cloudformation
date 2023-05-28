pipeline {
    agent any
    
    stages {
        stage('Pre-Build') {
            steps {
                sh "aws --version"
                sh "cfn_nag_scan  --version"
                sh "python3 /sqlmap/sqlmap.py"
                // Add your build commands here
            }
        }
        stage('Static Analysis') {
            steps {
                sh "cfn_nag_scan --input-path *.yaml --output-format json > cfn_nag_report.json || true"
                sh "/bin/bash /bin/cfn-nag-junit.sh cfn_nag_report.json"    
                archiveArtifacts "cfn_nag_report.json"
                junit "cfn_nag_junit.xml"
            }
        }
        stage('Deploy Application') {
            steps {
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY'),string(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_KEY')]) {
                    sh "aws configure set aws_access_key_id $AWS_ACCESS_KEY"
                    sh "aws configure set aws_secret_access_key $AWS_SECRET_KEY"
                    sh "aws configure set region us-east-2" //hard coded region
                    sh "aws sts get-caller-identity"
                    
                    // Deploy the infrastructure  
                    sh "aws cloudformation deploy --stack-name my-demo-stack --template-file main.yaml --parameter-overrides Region=us-east-2"
                }
            }
        }
        
        stage('Dynamic Scanning') {
            steps {
                echo 'Running tests...'
                // Add your test commands here
            }
        }
        
        stage('Post Deployment') {
            steps {
                echo 'Deploying...'
                // Add your deployment commands here
            }
        }
    }
}
