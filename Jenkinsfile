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
    stage('Deploy'){
      steps{
        sh 'kubectl apply -f deployment.yaml'
        sh 'kubectl apply -f service.yaml'
        sh 'echo http://`kubectl --namespace=${namespace} get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ip'` > ${feSvcName}'
      }
    }
  }
  
}
