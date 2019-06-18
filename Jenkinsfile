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
            }
        }
        stage("Tests") {
            steps {
                sh "bundle exec rspec --format html --out log/rspec_results.html"
            }
            post {
                always {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'log', reportFiles: 'rspec_results.html', reportName: 'HTML Report', reportTitles: ''])
                }
            }
        }
    }
}