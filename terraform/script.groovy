def buildDockerImage(String imageName) {
        echo "building the docker image..."
        sh "docker build -t $imageName ."
}

def dockerLogin() {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
         sh "echo $script.PASS | docker login -u $script.USER --password-stdin"
        }
}

def dockerPush(String imageName) {
        sh "docker push $imageName"
}

def deployApp() {
        sh "deploy "
}


