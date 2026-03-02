pipeline {
    agent any

    environment {
        IMAGE_NAME   = "mini-api"
        BASE_URL     = "http://localhost:3000"
        ARTIFACT_DIR = "artifacts"
    }

    options {
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Node Version') {
            steps {
                sh 'node --version || true'
                sh 'npm --version || true'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm ci'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'npm run test:unit'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:jenkins .'
            }
        }

        stage('Start App (Docker Compose)') {
            steps {
                sh 'docker compose down || true'
                sh 'docker compose up -d --build --wait'
            }
        }

        stage('Wait for Health') {
            steps {
                // --wait above already guarantees healthy; this is an extra safety check
                sh 'python3 scripts/wait_for_app.py ${BASE_URL}/health 30'
                // Fallback bash alternative:
                // sh 'bash scripts/healthcheck.sh ${BASE_URL}/health'
            }
        }

        stage('Integration Tests') {
            steps {
                sh 'BASE_URL=${BASE_URL} bash tests/integration/integration_test.sh'
                // Optional Newman run:
                // sh 'npm install -g newman'
                // sh 'BASE_URL=${BASE_URL} npm run test:integration:newman'
            }
        }
    }

    post {
        always {
            sh 'mkdir -p ${ARTIFACT_DIR}'
            sh 'bash scripts/collect_logs.sh ${ARTIFACT_DIR} || true'
            archiveArtifacts artifacts: 'artifacts/**', allowEmptyArchive: true
            sh 'docker compose down || true'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check logs in artifacts.'
        }
    }
}
