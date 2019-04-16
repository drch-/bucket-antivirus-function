FROM amazonlinux:2
RUN yum update -y
RUN yum install -y cpio python2-pip yum-utils zip https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN pip install --no-cache-dir virtualenv
WORKDIR /tmp

RUN yumdownloader -x \*i686 --archlist=x86_64 clamav clamav-lib clamav-update json-c pcre2
RUN rpm2cpio clamav-0*.rpm | cpio -idmv
RUN rpm2cpio clamav-lib*.rpm | cpio -idmv
RUN rpm2cpio clamav-update*.rpm | cpio -idmv
RUN rpm2cpio json-c*.rpm | cpio -idmv
RUN rpm2cpio pcre*.rpm | cpio -idmv

WORKDIR /opt/app
ADD requirements.txt .
ADD *.py ./
ADD ./build_lambda.sh .
RUN bash -c "./build_lambda.sh"
RUN mkdir /dist && cp lambda.zip /dist
