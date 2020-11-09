def GIT_BRANCH='master'           
pipeline {
    agent any
   // triggers {
    //    pollSCM('* * * * *')
   // }
    tools {
      maven 'maven-3.6.3'
    }
    environment {
        // Docker image versioning
        BUILD_NAME = readMavenPom().getArtifactId()
        BUILD_VERSION = readMavenPom().getVersion()
        IMAGE = "192.168.214.154/cp/${BUILD_NAME}:${BUILD_VERSION}"
        registry = "http://192.168.214.154"
        registryCredential = 'registry-cred'
    }
    stages {
        stage('Checkout Source Code') {
            steps {
                echo "====== Starting CHECKOUT SOURCE CODE ======"
	        script {
		   GIT_BRANCH = getGitBranch()
		}
		echo "Checkout branch: ${GIT_BRANCH}"
                checkout scm
          }
        }
        stage('Build Souce') {
            steps {
		echo "====== Starting Build Souce ======"
		sh script: 'mvn clean package'
		// sh "${M2_HOME}/mvn clean package"
            }
        }
        stage('Build image') {
            steps {
                echo "====== Starting BUILD IMAGE ======"
                echo "BUILD_NAME: ${BUILD_NAME}"
                echo "BUILD_VERSION: ${BUILD_VERSION}"
                echo "IMAGE: ${IMAGE}"
                script {
                    docker.withRegistry(registry, registryCredential) {
                        def dockerImage = docker.build("${env.IMAGE}")
                        println "Push dockerImage: " + dockerImage
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy in k8s Cluster') {
            steps {
		echo "====== Starting Deploy in K8S ======${env.kubectl}"
		script {
//		    kubernetesDeploy(
//		    	configs: 'my-app.yaml',
//			kubeconfigId: 'kubernetes-cluster-cert'
//			    withKubeConfig([credentialsId: 'kubernetes-cluster-cert', serverUrl: 'https://192.168.214.154:6443']) {
//      				sh 'kubectl apply -f my-app.yaml'
//    			     }
//		    )
		   sh "${env.kubectl} apply -f my-app.yaml"
		}
           }
        }
    }
}
def getGitBranch(){
	return scm.branches[0].name
}
