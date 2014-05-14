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
  robot.hear /(BANANA|MONKEE|MONKEEBOY|MONKEE-BOY|MBOY)/i, (msg) ->
    msg.send "(mboy)"
