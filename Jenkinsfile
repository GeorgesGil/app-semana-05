pipeline {
    agent any


    environment {
        token     = credentials('token')
        ssh_fingerprint = credentials('ssh_fingerprint')
        public_key    = credentials('public_key')
        private_key    = credentials('private_key')
        apply_timed_out = false
    }
	
    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    extensions: [], 
                    userRemoteConfigs: [[
                        url: 'https://github.com/GeorgesGil/app-semana-05.git'
                    ]]
                ])
          
            }
        }
		stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan -out tfplan -var "token=${token}" -var "ssh_fingerprint=${ssh_fingerprint}" -var "public_key=${public_key}" -var "private_key=${private_key}"'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Apply') {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            steps {
                script {
                    try {
                        sh 'terraform ${action} -input=false tfplan'
                    } catch (Exception e) {
                        env.apply_timed_out = true
                        throw e
                    }
                }
            }
        }
        stage('Destroy') {
            when {
                expression { return env.apply_timed_out == 'true' }
            }
            steps {
                script {
                    sh 'terraform ${action} --auto-approve'
                }
            }
        }
    
    }
}
