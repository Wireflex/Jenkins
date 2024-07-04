properties([disableConcurrentBuilds()])

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    
    stages {
        stage("Creating Docker Image") {
            steps {
                    sh 'echo "y" | docker system prune -a'
                dir ('Jenkins') {
                    sh 'docker build -t wireflex/jenkins . ' 
                }
            }
        }
        stage("DockerHub Login and Push") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_wireflex', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD && docker push wireflex/jenkins'
                }
            }
        }
        stage("Mutnaya hrenovina") {
            steps {
                   sh """
                   cat << 'EOF' > docker-compose.yml 
services:
  test:
    image: wireflex/jenkins
    ports:
      - '80:80'
    restart: unless-stopped
EOF
"""
                    sh 'scp -i ~/.ssh/id_rsa docker-compose.yml  root@94.142.141.77:.'
              }
         }
        stage("Deploying at Production server") {
            steps {
                   sh "ssh root@94.142.141.77 'docker compose down && echo \"y\" | docker system prune -a && docker compose up -d'"
            }
        }
    }
} 
