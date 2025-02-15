let counter = 0;

setInterval(() => {
  const n = new Date().toISOString();
  console.log(`[${n}] test1.js - running - counter: ${counter++}`);
}, 1000);
