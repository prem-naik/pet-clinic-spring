pipeline {
    agent any
    tools { 
        maven 'M3' 
    }
    environment {
        DOCKERCRED = credentials('dockerhub')
		DOCKER_USERNAME = "${DOCKERCRED_USR}"
		DOCKER_PASSWORD = "${DOCKERCRED_PSW}"
    }
	stages {
		stage ('Initialize') {
            steps {
                sh '''
                    echo "M2_HOME = ${M2_HOME}"
				''' 
            }
        }
		
		stage ('SCM Checkout'){
			steps{
				git url: 'https://github.com/prem-naik/pet-clinic-spring.git',
				branch: 'master'
			}
		}
		
		stage ('MAven Build'){
			steps{
				sh '''
					git clone 'https://github.com/spring-projects/spring-petclinic'
					cp Dockerfile deploy_app.yml hosts spring-petclinic
					cd spring-petclinic
					mvn clean install
				'''
			}
		}
	
	}
	
	post { 
        always { 
           cleanWs()
        }
    }  

}
