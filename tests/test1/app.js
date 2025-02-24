let counter = 0;

(async () => {
  while(true) {
    const n = new Date().toISOString();
    console.log(`[${n}] test1.js - running - counter: ${counter++}`);
    await new Promise(resolve => setTimeout(resolve, 10));
  }
})();
