# docker build . --tag test4:latest --tag test4:{{short}}
FROM test:latest

COPY app.js .
COPY package.json .
COPY package-lock.json .

RUN npm install
