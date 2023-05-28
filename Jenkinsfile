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
                sh "/bin/bash ./build/bin/cfn-nag-junit.sh cfn_nag_report.json"    
                archiveArtifacts "cfn_nag_report.json"
                xunit(
                    tools: [JUnit(pattern: 'cfn_nag_junit.xml')],
                    thresholds: [failed(failureThreshold: '30', unstableThreshold: '5')]
                    )
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
