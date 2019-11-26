FROM python:3-alpine as builder
RUN apk add --no-cache alpine-sdk libffi-dev openssl-dev python3-dev jq curl
COPY requirements.txt .
RUN pip install -r requirements.txt


FROM python:3-alpine
WORKDIR /plugin
COPY --from=builder /root/.cache /root/.cache
COPY --from=builder requirements.txt .
RUN pip install -r requirements.txt && rm -rf /root/.cache

RUN apk update \
    && apk add jq curl unzip\
    && rm -rf /var/cache/apk/*

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "/tmp/awscli-bundle.zip" \
    ; unzip /tmp/awscli-bundle.zip -d /tmp/ \
    ; /tmp/awscli-bundle/install -b /bin/aws \
    ; export PATH=/bin:$PATH \
    ; mkdir /.aws \
    ; touch /.aws/credentials \ 
    ; touch /.aws/config \
    ; rm -rf /tmp/*

COPY main.py ./
COPY upload_to_aws.sh ./
RUN chmod 777 ./upload_to_aws.sh

WORKDIR /drone/src

CMD ["python", "/plugin/main.py"]

