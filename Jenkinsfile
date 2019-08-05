//configurações de cores para as notificações slack
def COLOR_MAP = ['SUCCESS': 'good', 'FAILURE': 'danger', 'UNSTABLE': 'danger', 'ABORTED': 'danger']

pipeline {
    agent {
        docker {
            image "ruby:alpine"
        }
    }

    stages {
        stage("Build") {
            tools {nodejs "node"}       
            steps {
                sh "chmod +x build/alpine.sh"
                sh "./build/alpine.sh"
                sh "gem install bundler -v 2.0.2"
                sh "bundle install"

                sh "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash"

                sh 'export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm" [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"'
                sh "nvm install node 11"
                sh "nvm use node 11"

                sh "npm install -g allure-commandline"
            }
        }
        stage("Tests") {
            steps {
                sh "bundle exec rspec -fd -t @alerts --format html --out log/rspec_results.html"
            }
            post {
                always {
                    allure([
                        includeProperties: false,
                        properties: [],
                        reportBuildPolicy: 'ALWAYS',
                        results:[[path: 'allure-results']]
                    ])                 
                    //adiciona o publish HTML para gerar relatório
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'log', reportFiles: 'rspec_results.html', reportName: 'HTML Report', reportTitles: ''])
                     //configurações do plugin de relatório
                    cucumber failedFeaturesNumber: -1, failedScenariosNumber: -1, failedStepsNumber: -1, fileIncludePattern: '**/*.json', jsonReportDirectory: 'log', pendingStepsNumber: -1, skippedStepsNumber: -1, sortingMethod: 'ALPHABETICAL', undefinedStepsNumber: -1
                    //configurações do slack
                    slackSend channel: "#automacao-de-testes",
                        color: COLOR_MAP[currentBuild.currentResult],
                        message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n Mais informacoes acesse: ${env.BUILD_URL}"
                }
            }
        }
    }
}