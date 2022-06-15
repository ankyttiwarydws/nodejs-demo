pipeline 
{
   agent any
   environment{
        DOCKER_TAG = getDockerTag()
    }
 stages { 
 
   stage('Build'){   
      steps{
          
     withMaven(globalMavenSettingsConfig: 'null', jdk: 'jdk', maven: 'maven', mavenSettingsConfig: 'null') {
     sh "mvn clean package"
        }
      }
   }
   stage('Build Docker Image'){
            steps{
                sh "docker build . -t ankittiwaridws/demo:${DOCKER_TAG} "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                    sh "docker login -u ankittiwaridws -p ${dockerhub}"
                    sh "docker push ankittiwaridws/demo:${DOCKER_TAG}"
                }
            }
        }
 }
 post {
    failure {
        mail to: 'team@example.com',
            subject: 'Failed Pipeline',
            body: "Something is wrong"
    }
}
 }
 def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
     
 }
