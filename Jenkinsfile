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
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY')]) {
                    sh "echo $AWS_ACCESS_KEY"
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
