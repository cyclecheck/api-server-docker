FROM node:14.15.5-stretch
LABEL author=cyclecheck
LABEL repo='https://github.com/cyclecheck/api-server-docker'

COPY scripts/init.sh /
COPY scripts/start.sh /

ENV ENV_PATH=/data/cyclecheck.env
ENV NODE_DOCKER=true
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=8000
ENV DATA_DIR=/data
VOLUME /data

RUN apt-get update -qq \
  && apt-get install -y jq \
  && mkdir -p /opt/app \
  && chmod +x /init.sh \
  && chmod +x /start.sh \
  && chown -R node:node /opt /init.sh /start.sh /data \
  && npm install -g pm2 \
  && pm2 install pm2-logrotate

USER node
WORKDIR /opt/app

EXPOSE 8000

ENTRYPOINT ["/start.sh"]