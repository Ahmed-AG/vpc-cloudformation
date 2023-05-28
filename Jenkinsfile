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
        stage('Build') {
            steps {
                echo 'Building... V5'
                // Add your build commands here
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test commands here
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Add your deployment commands here
            }
        }
    }
}
