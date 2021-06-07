FROM jenkins/jenkins:lts-alpine

USER root

RUN apk -U add docker

RUN apk add --update shadow && \
  usermod -aG docker jenkins

    && groupadd -g 50 staff \
    && usermod -a -G staff jenkins

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins

RUN /usr/local/bin/install-plugins.sh \
greenballs \
locale \
publish-over-ssh \
ssh-slaves \
cloudbees-folder \
antisamy-markup-formatter \
build-timeout \
credentials-binding \
timestamper \
ws-cleanup \
workflow-aggregator \
pipeline-stage-view \
pipeline-github-lib \
github-branch-source \
git \
github \
pipeline-maven

# Create admin account for Jenkins
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

EXPOSE 8080 50000

VOLUME [ "/var/jenkins_home" ]

USER jenkins
