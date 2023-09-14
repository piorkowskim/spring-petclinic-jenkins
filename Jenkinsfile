pipeline {
	agent any
	stages {
	stage('Checkstyle') {
		steps {
			// runs checkstyle using  and saves result
			sh './mvnw checkstyle:checkstyle'
			archiveArtifacts artifacts: '**/target/checkstyle-result.xml', allowEmptyArchive: true
		}
	}
	
	stage('Test') {
		steps {
			// runs maven's tests
			sh './mvnw test'
		}
	}

	stage('Build') {
		steps {
		// builds the app without tests
		sh './mvnw clean install -DskipTests'
		}
	}

	stage('BuildDockerMrImage') {
		when {
			branch 'main'
		}
		steps {
		// builds image from docker repo
			script {
				app = docker.build('miloshsh/spring-petclinic')
				app.inside {
					sh 'echo im working!'
				}
			}
		}
	}

	stage('PushDockerMrImage') {
		when {
			branch 'main'
		}
		steps {
		// pushes image to docker repo with latest build number 
			script {
				docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
				app.push("${env.BUILD_NUMBER}")
				}
			}
		}
	}
		stages {
		stage('CreateDockerMainImage') {
			steps {
			// builds docker image using repo's dockerfile & pushes it to docker repo
				script {
					sh "docker build -t miloshsh/spring-petclinic:${env.BUILD_NUMBER} ."
					sh "docker push miloshsh/main:latest"
				}
			}
		}
	}
}
}

