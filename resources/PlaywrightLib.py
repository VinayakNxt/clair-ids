# playwright_log_capturer.py
import asyncio
from playwright.async_api import async_playwright

class PlaywrightLogCapturer:
    def __init__(self):
        self.console_logs = []
        self.network_requests = []

    async def _capture_logs(self, page):
        page.on("console", lambda msg: self.console_logs.append(msg.text))
        page.on("request", lambda req: self.network_requests.append(req.url))

    async def capture_logs(self, url):
        async with async_playwright() as p:
            browser = await p.chromium.launch()
            page = await browser.new_page()
            await self._capture_logs(page)
            await page.goto(url)
            await asyncio.sleep(1)  # Ensure all logs are captured before closing
            await browser.close()

    def get_logs(self):
        return self.console_logs, self.network_requests

def capture_logs_sync(url):
    capturer = PlaywrightLogCapturer()
    asyncio.run(capturer.capture_logs(url))
    return capturer.get_logs()
