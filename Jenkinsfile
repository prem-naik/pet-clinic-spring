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
	
	parameters {
        string(defaultValue: "", description: 'DEPLOY_TARGET', name: 'DEPLOY_TARGET')
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
		
		stage ('Maven Build'){
			steps{
				sh '''
					echo "Maven Build"
					git clone 'https://github.com/spring-projects/spring-petclinic'
					cp Dockerfile hosts deploy_app.yml spring-petclinic
					cd spring-petclinic
					mvn clean install
				'''
			}
		}
		
		stage ('Docker Build and Push'){
			steps{
				sh '''
					echo "Docker Build and Push"
					cd spring-petclinic
					docker build -t premnaik/spring-petclinic:latest .
					docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
					docker push premnaik/spring-petclinic:latest
				'''
			}
		}
		
		stage ('Deploy App') {
            steps {
                sh '''
					export ANSIBLE_HOST_KEY_CHECKING=False
					sed -i "s|ip_address|${DEPLOY_TARGET}|g" ./hosts
                    ansible-playbook -i ./hosts ./deploy_app.yml 
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
