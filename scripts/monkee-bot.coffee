# Description:
#   MBot needs a brain. This is an attempt at providing one.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   fleeting

module.exports = (robot) ->
  robot.hear /(MONKEE|MONKEEBOY|MONKEE-BOY|MBOY)/i, (msg) ->
    msg.send "(mboy)"

  robot.hear /BANANA/i, (msg) ->
    msg.send "(banana) Om Nom Nom Nom!"

  robot.hear /(left the room)/i, (msg) ->
    msg.send "Leaving? I'll miss that monkee. (okay)"

  robot.enter (msg) ->
    msg.send "Hey #{msg.message.user.name}, welcome to the jungle."  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"

  robot.leave (msg) ->
    msg.send "Aww, I'm going to miss #{msg.message.user.name}. (okay)"  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
