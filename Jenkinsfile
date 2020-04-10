pipeline {
    agent any
    environment {
      HOME = "${env.WORKSPACE}"
      DOCKER_REGISTRY = 'docker.chameleoncloud.org'
      DOCKER_REGISTRY_CREDS = credentials('kolla-docker-registry-creds')
    }

    stages {
      stage('docker-setup') {
        steps {
          sh 'docker login --username=$DOCKER_REGISTRY_CREDS_USR --password=$DOCKER_REGISTRY_CREDS_PSW $DOCKER_REGISTRY'
        }
      }
      stage('build-and-publish') {
        steps {
          sh 'make build'
          sh 'make publish'
        }
      }
    }
    
    post {
      always {
        sh 'docker logout $DOCKER_REGISTRY'
      }

      success {
        slackSend(
          channel: "#notifications",
          message: "*Build* of *keycloak* (${env.GIT_COMMIT.substring(0, 8)}) completed successfuly. <${env.RUN_DISPLAY_URL}|View build log>",
          color: "good"
        )

        // Trigger deploy to development environments
        build job: 'ansible-playbook', wait: false, parameters: [
          string(name: 'PLAYBOOK_NAME', value: 'keycloak'),
          string(name: 'JENKINS_AGENT_LABEL', value: 'ansible-uc-dev')
        ]
      }
    }
}
