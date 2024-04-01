(function() {
    var oldLog = console.log;
    console.log = function(message) {
        // Asynchronously store the message
        (async () => {
            // Example: Store in localStorage or send to a server here
            window.myConsoleLogs = window.myConsoleLogs || [];
            window.myConsoleLogs.push(message);
        })();
        // Call the original console.log function
        oldLog.apply(console, arguments);
    };
})();

(function() {
    var oldFetch = fetch;
    window.myNetworkLogs = window.myNetworkLogs || [];

    window.fetch = async function(...fetchArgs) {
        // Log the fetch request details asynchronously
        (async () => {
            window.myNetworkLogs.push({type: 'fetch', url: fetchArgs[0], options: fetchArgs[1]});
        })();

        // Proceed with the original fetch call
        const response = await oldFetch.apply(this, fetchArgs);

        // Optionally log response details
        // (async () => {
        //     window.myNetworkLogs.push({type: 'fetch-response', url: response.url, status: response.status});
        // })();
        console.log(response)
        return response;
    };
})();

async function downloadLogs() {
    const dataStr = JSON.stringify(window.myConsoleLogs, null, 2);
    const blob = new Blob([dataStr], {type : 'application/json'});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'consoleLogs.json';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}

async function myGoToKeyword(url, page, logger) {
    logger("Going to " + url)
    return await page.goto(url);
}


exports.__esModule = true;
exports.downloadLogs = downloadLogs;
exports.myGoToKeyword = myGoToKeyword;

