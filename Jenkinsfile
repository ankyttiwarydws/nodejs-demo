pipeline {
  agent any
  environment {
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
                    dockerImage.push("1")
                    }
                    }
                    sh 'docker push ankittiwaridws/demo:1'
                }
            }
        }
  
}
