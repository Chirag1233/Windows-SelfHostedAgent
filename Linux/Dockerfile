FROM microsoft/vsts-agent

#clean mysql error
RUN sudo apt-get purge mysql-server-5.7 \
  && sudo apt-get autoclean \
  && sudo apt-get clean \
  && sudo apt-get update

# Update packages and install new ones
RUN sudo apt-get update \
  && sudo apt-get upgrade -y \
  && sudo apt install apt-utils unzip -y

# Install Terraform
RUN curl -O https://releases.hashicorp.com/terraform/0.12.8/terraform_0.12.8_linux_amd64.zip \
  && unzip -o terraform_0.12.8_linux_amd64.zip -d /usr/local/bin/ \
  && export PATH="$PATH:/usr/local/bin"

# Insntall NPM Package
RUN sudo npm install -g eslint @vue/cli @vue/eslint-config-standard

# Set env variables
ENV VSTS_AGENT='$(hostname)-agent'
ENV VSTS_WORK='/var/vsts/$VSTS_AGENT'

CMD ["./start.sh"]