pipeline {

    triggers {
        githubPush()
    }

    agent {
        node {
            label 'build'
        }
    }

    tools { 
        maven 'maven-3.0.5'
        jdk 'java-1.8.0'
    }

    options {
        buildDiscarder logRotator( 
                    daysToKeepStr: '10', 
                    numToKeepStr: '5'
            )
    }

    environment {
        APP_NAME = "PetClinic"
        MAVEN_OPTS = " -Xmx512m"
        ARTIFACT = "/home/ec2-user/jenkins/workspace/petclinic-pipeline/target/petclinic.war"
        TOMCAT_DIR = "/var/lib/tomcat/webapps"
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace for ${APP_NAME}"
                """
            }
        }

        stage('Clone sources') {
            steps {
                git branch: 'main',
                    credentialsId: 'git-ssh',
                    url: 'git@github.com:volodymyrmarkiv/final-petclinic.git'
                sh 'ls -la'
            }
        }

        stage('Testing') {
            steps {
                sh "mvn clean verify sonar:sonar -Dsonar.login=5da0e763d3a08c1006b50ebdf443eb15a827edbc"
            }
        }

        stage('Code Build') {
            steps {
                 sh 'mvn package'
            }
        }
        stage('Deploy artifact to web-server') {
            steps {
                  sshagent (credentials: ['ssh-aws-key']) {
                    sh 'scp -o StrictHostKeyChecking=no ${ARTIFACT} ec2-user@172.31.0.11:${TOMCAT_DIR}'
                }
            }
        }

    }   
}