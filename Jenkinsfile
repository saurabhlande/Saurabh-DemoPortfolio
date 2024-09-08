pipeline {
    agent any

    stages {
        stage('Code') {
            steps {
                echo "Cloning the code"
				git url:"<URL>", branch:"main"
            }
        }
		stage('Build') {
            steps {
                echo "Building the image"
				sh  “docker build -t my-note-app”
            }
        }
		stage('Push image on Docker Hub') {
            steps {
                echo "Pushing the image on Docker Hub"
				
				# use Credentials like username & password for login inside the dockerHub
				withCredentials([usernamePassword(credentialsId:"dockerHub", passwordVariable:"dockerHubPass", usernameVariable:"dockerHubUser")])
				
				# use for tag the the project name with "username/<peoject_name>" when send on DockerHub
				sh "docker tag my-note-app ${env.dockerHubUser}/my-note-app:letest"
				sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
				sh "docker push ${env.dockerHubUser}/my-note-app:letest"
            }
        }
		stage('Deploy') {
            steps {
                echo "Deploy on the container"
				#sh "docker run -d -p 8000:8000 <dockerHubUser>/my-note-app:letest"
				#But If we run our application using the docker run command then it will run the first time successfully. 
				#Then the error will be shown a second time because the 8000 port is already used. 
				#So for that, we need to use docker-compose it we run container automaticaly we no need to put container name.
				sh "docker-compose down && docker-compose up"
            }
        }
    }
}
