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
            steps {
                sh "chmod +x build/alpine.sh"
                sh "./build/alpine.sh"
                sh "gem install bundler -v 2.0.2"
                sh "bundle install"
                sh "bundle update"
            }
        }
           
        stage("Tests") {
            steps {
                sh "bundle exec rspec -fd --format html --out log/rspec_results.html"
            }
            post {
                always{
                
                   //adiciona o publish HTML para gerar relatório
                   publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'log', reportFiles: 'rspec_results.html', reportName: 'HTML Report', reportTitles: ''])
                   //configurações do slack
                   slackSend channel: "#automacao-de-testes",
                        color: COLOR_MAP[currentBuild.currentResult],
                        message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n Mais informacoes acesse: ${env.BUILD_URL}"
                  
                    //envio de email
                    emailext attachLog: true, attachmentsPattern: 'log/rspec_results.html', body: 'Relatório final jenkins', replyTo: 'lucaspolimig96@gmail.com', subject: 'Execução Testes Jenkins', to: 'lucaspolimig96@gmail.com'    
                  }
            }
         }
    }
}