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
            /*agent{
                docker{
                    image "node:10.16-alpine"
                }
            }*/
            tools {nodejs "nodejs"}

            steps {
                sh "chmod +x build/alpine.sh"
                sh "./build/alpine.sh"
                sh "gem install bundler -v 2.0.2"
                sh "bundle install"

                //sh 'npm config ls'
                //sh "npm install -g allure-commandline"
            }
        }
           
        stage("Tests") {
            steps {
                sh "bundle exec rspec -fd -t @alerts --format html --out log/rspec_results.html"
            }
            post {
                always{
                  node('') {
                          //allure results: [[path: 'allure-results']]
                          allure includeProperties: false, jdk: '', results: [[path: 'allure-results']]
                  }
              }
              
              //  always {
              
                       // allure includeProperties: false, jdk: '', results: [[path: 'allure-results'], [path: 'allure-results']]
                
                                  
                    //adiciona o publish HTML para gerar relatório
                  //  publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'log', reportFiles: 'rspec_results.html', reportName: 'HTML Report', reportTitles: ''])
                     //configurações do plugin de relatório
                   // cucumber failedFeaturesNumber: -1, failedScenariosNumber: -1, failedStepsNumber: -1, fileIncludePattern: '**/*.json', jsonReportDirectory: 'log', pendingStepsNumber: -1, skippedStepsNumber: -1, sortingMethod: 'ALPHABETICAL', undefinedStepsNumber: -1
                    //configurações do slack
                   // slackSend channel: "#automacao-de-testes",
                       // color: COLOR_MAP[currentBuild.currentResult],
                       // message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n Mais informacoes acesse: ${env.BUILD_URL}"
                //}
            }
        }
    }
}