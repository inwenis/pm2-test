const axios = require('axios');

setInterval(async () => {
  const urls = [
    'http://nonexistent.url', // Non-existent domain
    'http://httpstat.us/404', // 404 Not Found
    'http://httpstat.us/500', // 500 Internal Server Error
    'http://httpstat.us/403', // 403 Forbidden
    'http://httpstat.us/400'  // 400 Bad Request
  ];

  for (const url of urls) {
    const n = new Date().toISOString();
    try {
      const r = await axios.get(url);
      console.log(`[${n}] received ${r.data.length} elements from ${url}`);
    } catch (e) {
      console.log(`[${n}] Error sending GET to ${url}`, e);
      console.error(`[${n}] Error sending GET to ${url}`, e);
    }
  }
}, 10);
