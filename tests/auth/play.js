const { chromium } = require('playwright');
// const { debugConsole} = require('debug')('playwright:console')

// (async () => {
//   const browser = await chromium.launch({ headless: false });
//   const page = await browser.newPage();

//   page.on('console', msg => {
//     console.log(`Console message: ${msg.type()} - ${msg.text()}`);
//   });

//   await page.goto('https://arnetta.adaptnxt.in/rmswebapp/login');

//   await page.waitForTimeout(10000);

//   await browser.close();
// })();

async function browserLogs(url, page) {
//   const browser = await chromium.launch({ headless: false });
//   const page = await browser.newPage();
  let logs = [];
  
  await page.on('console', (msg) => {
    if (msg && msg.text) {
      if (typeof msg.text === 'function') {
        debugConsole('PAGE LOG:', msg.text());
      } else {
        debugConsole('PAGE LOG:', msg.text);
      }
    } else {
      debugConsole('PAGE LOG:', msg);
    }
});

  await page.goto(url);

  await page.waitForTimeout(20000);

//   await browser.close();

  return logs;
} 

exports.__esModule = true;
exports.browserLogs = browserLogs;