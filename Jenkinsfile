def DockerTag() {
	def tag = sh script: 'git rev-parse HEAD', returnStdout:true
	return tag
	}

pipeline {
  agent any
  environment {
    registry = "ankittiwaridws/demo"
    imagename = "ankittiwaridws/dem"
    dockerImage = ''
registryCredential = 'dockerhub'
    SONAR_HOME = "${tool name: 'sonar-scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'}"
    DOCKER_TAG = DockerTag()
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
     stage('SonarQube_Analysis') {
      steps {
	    script {
          scannerHome = tool 'sonar-scanner'
        }
        withSonarQubeEnv('sonar') {
      	  sh """${scannerHome}/bin/sonar-scanner"""
        }
      }	
    }	
	  stage('Quality_Gate') {
	   steps {
	    timeout(time: 3, unit: 'MINUTES') {
		  waitForQualityGate abortPipeline: true
        }
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
         dockerImage.push("tag")
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
 
post {
    always {
sh 'echo "This will always run"'
mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Success: Project name -> ${env.JOB_NAME}", to: "ankyttiwarydws@gmail.com";
    }
    failure {
sh 'echo "This will run only if failed"'
      mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br>URL: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR: Project name -> ${env.JOB_NAME}", to: "ankyttiwarydws@gmail.com";
    }
  }  
}
