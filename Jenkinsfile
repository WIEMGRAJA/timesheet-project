pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'wiemkaraja'
        DOCKERHUB_REPO = 'timesheet-app'
        IMAGE_VERSION  = '1.1'
        K8S_NAMESPACE  = 'chap4'
        K8S_DEPLOYMENT = 'timesheet-dep'
        K8S_CONTAINER  = 'timesheet'
        KUBECONFIG     = '/var/lib/jenkins/.kube/config'
    }

    stages {
        stage('GIT') {
            steps {
                checkout scm
            }
        }

        stage('COMPILATION') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('INSTALLATION') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USERNAME',
                    passwordVariable: 'DOCKERHUB_PASSWORD'
                )]) {
                    sh """
                      docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${IMAGE_VERSION} .
                      echo "\$DOCKERHUB_PASSWORD" | docker login -u "\$DOCKERHUB_USERNAME" --password-stdin
                      docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${IMAGE_VERSION}
                    """
                }
            }
        }

        stage('DEPLOIEMENT') {
    steps {
        sh """
          export KUBECONFIG=${KUBECONFIG}
          kubectl config use-context minikube
          kubectl set image deployment/${K8S_DEPLOYMENT} \
            ${K8S_CONTAINER}=${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${IMAGE_VERSION} \
            -n ${K8S_NAMESPACE}
          kubectl rollout status deployment/${K8S_DEPLOYMENT} -n ${K8S_NAMESPACE}
        """
    }
}
    }
}
