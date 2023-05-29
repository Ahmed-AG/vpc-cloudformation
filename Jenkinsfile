pipeline {
    agent any
    
    stages {
        stage('Check Tools') {
            steps {
                sh "aws --version"
                sh "cfn_nag_scan  --version"
                sh "python3 /sqlmap/sqlmap.py"
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
                    sh 'LoggedInAs=$(aws sts get-caller-identity | grep user | cut -d\'/\' -f2)'
                    
                    // Deploy the infrastructure  
                    sh "bash bin/deploy_cfn.sh"
                }
            }
        }
        
        stage('Dynamic Scanning') {
            steps {
                echo 'Running tests...'
            }
        }
        
        stage('Post Deployment') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
