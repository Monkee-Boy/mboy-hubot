# Description:
#   Returns weather information from Forecast.io with a sprinkling of Google maps.
#
# Configuration:
#   HUBOT_WEATHER_CELSIUS - Display in celsius
#   HUBOT_FORECAST_API_KEY - Forecast.io API Key
#
# Commands:
#   hubot weather - Get the weather for Austin, Texas.
#
# Author:
#   markstory
#   mbmccormick
#
# Modified by @fleeting for MBot
env = process.env

forecastIoUrl = 'https://api.forecast.io/forecast/' + process.env.HUBOT_FORECAST_API_KEY + '/'
googleMapUrl = 'http://maps.googleapis.com/maps/api/geocode/json'

lookupAddress = (msg, location, cb) ->
  msg.http(googleMapUrl).query(address: location, sensor: true)
    .get() (err, res, body) ->
      try
        body = JSON.parse body
        coords = body.results[0].geometry.location
      catch err
        err = "Could not find #{location}"
        return cb(msg, null, err)
      cb(msg, coords, err)

lookupWeather = (msg, coords, err) ->
  return msg.send err if err
  return msg.send "You need to set env.HUBOT_FORECAST_API_KEY to get weather data" if not env.HUBOT_FORECAST_API_KEY

  url = forecastIoUrl + coords.lat + ',' + coords.lng

  msg.http(url).query(units: 'ca').get() (err, res, body) ->
    return msg.send 'Could not get weather data' if err
    try
      body = JSON.parse body
      current = body.currently
    catch err
      return msg.send "Could not parse weather data."
    humidity = (current.humidity * 100).toFixed 0
    temperature = getTemp(current.temperature)
    text = "(mboy) It is currently #{temperature} #{current.summary}, #{humidity}% humidity in Austin, Texas."
    msg.send text

getTemp = (c) ->
  if env.HUBOT_WEATHER_CELSIUS
    return c.toFixed(0) + "ºC"
  return ((c * 1.8) + 32).toFixed(0) + "ºF"


module.exports = (robot) ->
  robot.respond /weather/i, (msg) ->
    lookupAddress(msg, 'Austin, Texas', lookupWeather)
