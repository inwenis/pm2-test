# docker build . --tag test2:latest --tag test2:{{short}}
FROM test:latest

COPY app.js .
COPY package.json .
COPY package-lock.json .

RUN npm install
