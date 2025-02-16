const axios = require('axios');

setInterval(async () => {
  const urls = [
    'https://jsonplaceholder.typicode.com/posts',
    'https://jsonplaceholder.typicode.com/comments',
    'https://jsonplaceholder.typicode.com/albums',
    'https://jsonplaceholder.typicode.com/photos',
    'https://jsonplaceholder.typicode.com/todos'
  ];

  for (const url of urls) {
    try {
      const r = await axios.get(url);
      const n = new Date().toISOString();
      console.log(`[${n}] received ${r.data.length} elements from ${url}`);
    } catch (e) {
      console.error(`Error sending GET to ${url}`, e);
    }
  }

  const postUrl = 'https://jsonplaceholder.typicode.com/posts';
  try {
    const postData = {
      title: 'foo',
      body: 'bar',
      userId: 1
    };
    const postResponse = await axios.post(postUrl, postData);
    const n = new Date().toISOString();
    console.log(`[${n}] send POST to ${postUrl} received ${postResponse.status} response`);
  } catch (e) {
    console.error(`Error sending POST to ${postUrl}:`, e);
  }

}, 10);
