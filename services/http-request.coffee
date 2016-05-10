http = require('http')
querystring = require('querystring')
exports.request = (options, data) ->
  req = http.request(options, (res) ->
    console.log 'Status: ' + res.statusCode
    console.log 'Headers: ' + JSON.stringify(res.headers)
    res.setEncoding 'utf8'
    res.on 'data', (body) ->
      console.log 'Body: ' + body
      return
    return
  )
  req.on 'error', (e) ->
    console.log 'problem with request: ' + e.message
    return
  # write data to request body
  req.write querystring.stringify(data)
  req.end()
