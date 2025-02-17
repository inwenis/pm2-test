# docker build . --tag test3:latest test3:{{short}}
FROM test:latest

COPY app.js .
COPY package.json .
COPY package-lock.json .

RUN npm install
