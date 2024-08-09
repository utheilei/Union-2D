function getRequestAsync(url, successfulCallback, failedCallback) {
    let xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            console.info("status: " + xhr.status)
            if (xhr.status === 200) {
                let response = {
                    headers : xhr.getAllResponseHeaders(),
                    content : xhr.response
                }
                successfulCallback(response)
            } else {
                let error = {
                    status : xhr.status,
                    statusText : xhr.statusText
                }
                failedCallback(error)
            }
        }
    }
    xhr.open("GET", url)
    xhr.send()
    return xhr
}

function abort(xhr) {
    xhr.abort()
}

function getRequestSync(url) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, false);
    var res = ""
    try {
        xhr.send();
        if (xhr.status === 200) {
            console.log(xhr.responseText);
            res = xhr.responseText;
        } else {
            console.error("Error: " + xhr.status);
        }
    } catch (e) {
        res = e.message
        console.error("Caught Exception: " + res);
    }
    return res
}

function postRequestAsync(url, data, successfulCallback, failedCallback) {
    let xhr = new XMLHttpRequest()
    console.log(url + "data:" + data);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            console.info("status: " + xhr.status)
            if (xhr.status === 200) {
                var str = xhr.response
                console.info("response: " + str)
                let response = {
                    headers : xhr.getAllResponseHeaders(),
                    content : str
                }
                successfulCallback(response)
            } else {
                let error = {
                    status : xhr.status,
                    statusText : xhr.statusText
                }
                failedCallback(error)
            }
        }
    }
    xhr.open("POST", url)
    xhr.setRequestHeader('Content-Type', 'application/json')
    xhr.send(data)
    return xhr
}
