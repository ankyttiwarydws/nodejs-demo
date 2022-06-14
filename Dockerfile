FROM node:alpine3.10
WORKDIR /app
COPY . /app
RUN npm install
EXPOSE 5000
ENTRYPOINT ["node", "./index.js"]
