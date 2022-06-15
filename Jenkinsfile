pipeline {
  agent any
  environment {
imagename = "ank/dem"
dockerImage = ''
  }
  tools {
    node 'node'
    dockerTool 'docker'
  }
  stages {
    stage('Build') {
      steps {
        sh 'npm install'
      }
    }
    stage('DockerBuilderPublisher'){
      steps{
       script {
         dockerImage = docker.build imagename
        }   
        }
    }
    stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                    sh 'docker login -u ankittiwaridws -p ${dockerhub}'
                    sh 'docker push ankittiwaridws/demo:1'
                }
            }
        }
  
}   
}
