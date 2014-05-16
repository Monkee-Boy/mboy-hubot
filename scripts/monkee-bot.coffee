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

  robot.hear /@DEV/i, (msg) ->
    msg.send "(mboy) Hey @fleeting, @SarahHigley, and @CraigKahle, you are hereby summoned."

  robot.hear /@DESIGN/i, (msg) ->
    msg.send "(mboy) Hey @NikkiClark, @steph, and @AutumnHutchins, you are hereby summoned."

  robot.hear /@MARKETING/i, (msg) ->
    msg.send "(mboy) Hey @JoePickerill and @AdamLefton, you are hereby summoned."

  robot.hear /@MGMT/i, (msg) ->
    msg.send "(mboy) Hey @BossMan and @JoePickerill, you are hereby summoned."

  robot.hear /ANDREA/i, (msg) ->
    msg.send "(mboy) Aww, I miss Andrea. (grumpycat)"

  # TODO: Need to solve a few issues with these calling more than they should.
  # robot.enter (msg) ->
  #   msg.send "Hey #{msg.message.user.name}, welcome to the jungle."  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
  #
  # robot.leave (msg) ->
  #   msg.send "Aww, I'm going to miss #{msg.message.user.name}. (okay)"  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
