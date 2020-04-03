.pragma library

function pathToUrl(path) {
    return  encodeURIComponent("file://"+path)
}

function urlToPath(urldata) {
    var path = urldata.toString()
    path = path.replace(/^(file:\/{2})/,"")     // remove prefixed "file://"
    return decodeURIComponent(path)             // unescape html codes like '%23' for '#'
}
