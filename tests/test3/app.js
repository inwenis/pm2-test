const WebSocket = require('ws');

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

function connect() {
  const ws = new WebSocket('wss://echo.websocket.org/');

  ws.on('open', function open() {
    console.log('Connected to the WebSocket server');
    setInterval(() => {
      const randomString = Math.random().toString(36).repeat(getRandomInt(100));
      ws.send(randomString);
    }, 50);
  });

  ws.on('message', function incoming(data) {
    console.log('Received data:', data);
  });

  ws.on('error', function error(err) {
    console.error('WebSocket error:', err);
  });

  ws.on('close', function close() {
    console.log('Disconnected from the WebSocket server');
    setTimeout(connect, 2000);
  });

}

connect();
