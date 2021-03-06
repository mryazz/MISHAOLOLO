const { remote } = require('webdriverio');
const puppeteer = require('puppeteer-core');
const host = '172.18.0.1';
(async () => {
    const browser = await remote({
        hostname: host,
        path: '/wd/hub',
        capabilities: {
            browserName: 'chrome',
            browserVersion: '90.0',
            'selenoid:options': {
                enableVNC: true,
                enableVideo: true,
                enableLog: true,
                logName: `${+(new Date())}selenoid.log`,
            }
        }
    }).catch(e => {
        console.log(e)
    });

    const devtools = await puppeteer.connect(
        { browserWSEndpoint: `ws://${host}:4444/devtools/${browser.sessionId}` }
    );
    const page = await devtools.newPage();
    await page.goto('http://google.com');
    await page.screenshot({path: 'screenshot.png'});
    const title = await page.title();

    console.log(title);

    await devtools.close();
    await browser.deleteSession();
})();