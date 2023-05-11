pipeline {
     agent any
     
     tools {nodejs "NodeJS"}
     
     stages {
        stage("Build") {
            steps {
                sh "npm install"
                echo 'Building NextJS App'
		      sh 'node_modules/next/dist/bin/next build'
            }
        }
        stage("Deploy") {
            steps {
                sh "cp -r ${WORKSPACE}/build/ /var/www/jenkins-react-app"
            }
        }
    }
}
