pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = "wiemkaraja/timesheet-app"
        IMAGE_TAG      = "1.1"
        K8S_NAMESPACE  = "chap5"         // ou chap4 si tu refais tout là-bas
        K8S_DEPLOYMENT = "timesheet-dep"
        K8S_CONTAINER  = "timesheet"
    }

    stages {
        stage('GIT') {
            steps {
                checkout scm
            }
        }

        stage('COMPILATION') {
            steps {
                sh 'mvnw clean package -DskipTests'
            }
        }

        stage('INSTALLATION') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',   // ID à créer dans Jenkins
                    usernameVariable: 'DOCKERHUB_USERNAME',
                    passwordVariable: 'DOCKERHUB_PASSWORD'
                )]) {
                    sh """
                      docker build -t ${DOCKERHUB_REPO}:${IMAGE_TAG} .
                      echo "\$DOCKERHUB_PASSWORD" | docker login -u "\$DOCKERHUB_USERNAME" --password-stdin
                      docker push ${DOCKERHUB_REPO}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('DEPLOIEMENT') {
            steps {
                sh """
                  kubectl set image deployment/${K8S_DEPLOYMENT} \\
                    ${K8S_CONTAINER}=${DOCKERHUB_REPO}:${IMAGE_TAG} \\
                    -n ${K8S_NAMESPACE}
                  kubectl rollout status deployment/${K8S_DEPLOYMENT} -n ${K8S_NAMESPACE}
                """
            }
        }
    }
}
