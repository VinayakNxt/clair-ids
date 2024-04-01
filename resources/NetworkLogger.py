# sync_playwright_capturer.py
import asyncio
from playwright.async_api import async_playwright
from threading import Thread
from queue import Queue

def run_async_code(url, result_queue):
    async def async_capture_logs():
        async with async_playwright() as p:
            browser = await p.chromium.launch()
            page = await browser.new_page()

            console_logs = []
            page.on("console", lambda msg: console_logs.append(msg.text))

            network_requests = []
            page.on("request", lambda req: network_requests.append(req.url))

            await page.goto(url)
            await browser.close()

            return console_logs, network_requests

    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    result = loop.run_until_complete(async_capture_logs())
    loop.close()
    result_queue.put(result)

class PlaywrightLogCapturer:
    def capture_logs(self, url):
        result_queue = Queue()
        thread = Thread(target=run_async_code, args=(url, result_queue))
        thread.start()
        thread.join()
        console_logs, network_requests = result_queue.get()
        return console_logs, network_requests
