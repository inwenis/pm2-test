# docker build . --tag test3:latest
FROM test:latest

COPY app.js .
COPY package.json .
COPY package-lock.json .

RUN npm install
