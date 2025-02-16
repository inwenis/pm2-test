# docker build . --tag test2:latest
FROM test:latest

COPY app.js .
COPY package.json .
COPY package-lock.json .

RUN npm install
