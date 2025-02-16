# docker build . --tag test3-pm2:latest
FROM test3:latest

COPY . .

RUN npm install pm2@5.4.3 -g

CMD ["pm2-runtime", "ecosystem.config.json"]
