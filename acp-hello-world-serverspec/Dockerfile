FROM node:latest
RUN mkdir -p /usr/src/app && chown -R node /usr/src/app
WORKDIR /usr/src/app
# UID for the node user
USER 1000
COPY . .
RUN npm install --quiet && npm test
EXPOSE 4000
CMD npm start
