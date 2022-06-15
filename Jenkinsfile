pipeline {
  agent any
  environment {
    registry = "ankittiwaridws/demo"
    imagename = "ankittiwaridws/dem"
    dockerImage = ''
registryCredential = 'dockerhub'
  }
  tools {
    nodejs 'node'
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
       script {
         docker.withRegistry( '', registryCredential ) {
         dockerImage.push('1')
         dockerImage.push('latest')
                    }
                    }
                    
                }
            }
        }
  
}
