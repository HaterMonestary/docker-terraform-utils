FROM alpine:3.9

RUN apk add --update --no-cache python3 ca-certificates groff less bash bash-completion make jq gettext-dev coreutils curl wget zip git openssh-client

ENV TERRAFORM_VERSION=0.12.9
RUN curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /tmp/ && \
    mv /tmp/terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    rm -rf /tmp/terraform.zip

ENV AWSCLI_VERSION=1.16.214
RUN pip3 --no-cache-dir install --upgrade awscli==${AWSCLI_VERSION}

ENV TERRAFORM_DOCS_VERSION 0.6.0
RUN curl -L -o /usr/local/bin/terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 && \
    chmod +x /usr/local/bin/terraform-docs

ENV GIT_CHGLOG_VERSION 0.7.1
RUN curl -L -o /usr/local/bin/git-chglog https://github.com/git-chglog/git-chglog/releases/download/${GIT_CHGLOG_VERSION}/git-chglog_linux_amd64 && \
    chmod +x /usr/local/bin/git-chglog

RUN mkdir -p /work

#Add tests
COPY run_tests.sh /run_tests.sh

WORKDIR /work

CMD ["/bin/bash"]
