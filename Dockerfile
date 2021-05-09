FROM registry.access.redhat.com/ubi8

USER 0

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN yum update && yum install -y \
python3 \
python3-pip \
git \
curl \
unzip

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN curl "Https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/aws

RUN curl -L "$(curl -s https://api.github.com/repos/accurics/terrascan/releases/latest | grep -o -E https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz
RUN tar -xf terrascan.tar.gz terrascan && rm terrascan.tar.gz
RUN install terrascan /usr/local/bin && rm terrascan

ENTRYPOINT [""]