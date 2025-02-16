# docker build . --tag test2-pm2:latest
FROM test2:latest

COPY . .

RUN npm install pm2@5.4.3 -g

CMD ["pm2-runtime", "ecosystem.config.json"]
