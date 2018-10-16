FROM node:10-alpine

LABEL maintainer='Michaël "e7d" Ferrand <michael@e7d.io>'

WORKDIR /app
COPY server/node/package*.json ./
COPY server/node/server.js ./
COPY web /opt/web

RUN cd /opt/web \
    && npm run prod \
    && mv /opt/web/dist /app/web \
    && rm -rf /opt/web

RUN npm install --production \
    && npm ci \
    && npm cache clean --force

EXPOSE 80
CMD [ "node", "server.js" ]