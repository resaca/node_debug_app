httpModule = require './http-request'
request = require 'request'
conf = require '../config/conf.json'

buildOptions = ->
  options =
    hostname: 'apifv.foneverify.com'
    port: 80
    path: '/U2opia_Verify/v1.0/trial/sms'
    # path: '/U2opia_Verify/v1.0/flow/sms'
    method: 'POST'
    headers: 'Content-Type': 'application/x-www-form-urlencoded'

  return options

buildData = (country_code, phone) ->
  data =
    customerId: conf.phone_verify_customer_id
    isoCountryCode: country_code
    msisdn: phone
    appKey: conf.phone_verify_app_key
  return data

module.exports =
  send_otp: (country_code, phone) ->
    data = buildData(country_code, phone)
    # request.post('http://apifv.foneverify.com/U2opia_Verify/v1.0/trial/sms').form(data)
    httpModule.request buildOptions(), data
