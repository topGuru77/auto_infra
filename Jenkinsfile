pipeline {
    agent any

    environment {
        GIT_REPO = "https://github.com/topGuru77/auto_infra.git"
        BRANCH = "main"
        GIT_USER_NAME = "topGuru77"
        GIT_USER_EMAIL = "kwamenadollar17@yahoo.com"
    }

    stages {
        stage('SCM checkout Code') {
            steps {
                script {
                    // Handle existing directory
                    sh '''
                        if [ -d "auto_infra" ]; then
                            echo "Directory 'auto_infra' already exists. Pulling latest changes."
                            cd auto_infra
                            git config --global user.email "$GIT_USER_EMAIL"
                            git config --global user.name "$GIT_USER_NAME"
                            git reset --hard
                            git pull origin $BRANCH
                        else
                            echo "Cloning repository."
                            git config --global user.email "$GIT_USER_EMAIL"
                            git config --global user.name "$GIT_USER_NAME"
                            git clone $GIT_REPO auto_infra
                        fi
                    '''
                }
            }
        }

        stage('Debug Terraform Variables') {
            steps {
                dir('auto_infra') {
                    sh '''
                        echo "Checking if jenkins.auto.tfvars exists..."
                        if [ -f "jenkins.auto.tfvars" ]; then
                            echo "jenkins.auto.tfvars file found:"
                            cat jenkins.auto.tfvars
                        else
                            echo "jenkins.auto.tfvars file NOT found!"
                            exit 1
                        fi
                    '''
                }
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                dir('auto_infra') {
                    sh '''
                        terraform init
                        terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('auto_infra') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Auto Git Commit & Push') {
            steps {
                dir('auto_infra') {
                    withCredentials([string(credentialsId: 'GITHUB_PAT', variable: 'PAT')]) {
                        sh '''
                            CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
                            git add .
                            git commit -m "Auto commit after Terraform apply" || echo "Nothing to commit"
                            git push https://$GIT_USER_NAME:$PAT@github.com/topGuru77/auto_infra.git $CURRENT_BRANCH
                        '''
                    }
                }
            }
        }
    }
}