pipeline {
    agent any
    
    stages {
        stage('Pre-Build') {
            steps {
                sh "aws --version"
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
