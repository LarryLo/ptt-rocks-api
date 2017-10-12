FROM python:3

ENV GOOGLE_APPLICATION_CREDENTIALS /opt/ptt-rocks-api/oauth.json
RUN \
  apt-get update && apt-get install -y \
    lsb-release && \
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update && apt-get install -y \
    locales \
    google-cloud-sdk \
    openssl && \
  pip install --no-cache-dir \
    Flask \
    urllib3 \
    google-cloud-storage \
    pyquery \
    elasticsearch && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  localedef -i en_US -f UTF-8 en_US.UTF-8 

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV FLASK_APP /opt/ptt-rocks-api/app.py
ENTRYPOINT python -m flask run 
