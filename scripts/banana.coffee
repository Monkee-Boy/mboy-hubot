# Description:
#   MBot loves bananas.
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
  robot.hear /BANANA/i, (msg) ->
    msg.send "(mboy)"
