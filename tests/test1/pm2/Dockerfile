# docker build . --tag test1-pm2:latest --tag test1-pm2:{{short}}
FROM test1:latest

COPY . .

RUN npm install pm2@5.4.3 -g

CMD ["pm2-runtime", "ecosystem.config.json"]
