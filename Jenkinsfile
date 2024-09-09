pipeline {
    agent any

    stages {
        stage('Code') {
            steps {
                echo "Cloning the code"
                git url: "https://github.com/saurabhlande/saurabh_demo_portfolio", branch: "main"
            }
        }
        stage('Build') {
            steps {
                echo "Building the image"
                sh "docker build -t saurabh_demo_portfolio ."
                echo "Build Done"
            }
        }
        stage('Push image on Docker Hub') {
            steps {
                echo "Pushing the image on Docker Hub"
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    
                    // Tag the image with DockerHub username and project name
                    sh 'docker tag saurabh_demo_portfolio ${dockerHubUser}/saurabh_demo_portfolio:latest'
                    
                    // Login to DockerHub
                    sh 'echo ${dockerHubPass} | docker login -u ${dockerHubUser} --password-stdin'
                    
                    // Push the image to DockerHub
                    sh 'docker push ${dockerHubUser}/saurabh_demo_portfolio:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying on the container"
                // Ensure docker-compose is in the correct directory and points to the correct file
                sh "docker-compose down && docker-compose up -d"
            }
        }
    }
}
