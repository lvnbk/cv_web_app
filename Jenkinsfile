pipeline {
     agent any
     
     tools {nodejs "NodeJS"}
     
     stages {
        stage("Build") {
            steps {
                sh "npm install"
                sh "npm run build"
            }
        }
        stage("Deploy") {
            steps {
                sh "cp -r ${WORKSPACE}/build/ /var/www/jenkins-react-app"
            }
        }
    }
}
