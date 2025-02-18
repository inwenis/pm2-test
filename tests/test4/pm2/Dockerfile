# docker build . --tag test4-pm2:latest --tag test4-pm2:{{short}}
FROM test4:latest

COPY . .

RUN npm install pm2@5.4.3 -g

CMD ["pm2-runtime", "ecosystem.config.json"]
