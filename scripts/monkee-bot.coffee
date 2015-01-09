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
  robot.hear /(MONKEE|MBOY)/i, (msg) ->
    msg.send "(mboy)"

  robot.hear /BANANA/i, (msg) ->
    msg.send "(banana) Om Nom Nom Nom!"

  robot.hear /(BABY|CUNNING|FIREFLY|SHINY)/i, (msg) ->
    msg.send "(bicepleft) (cunningbaby) (bicepright)"

  robot.hear /@AdamLefton/i, (msg) ->
    msg.send "(iamawarhero) The war hero we deserve."

  robot.hear /.*(coffee me).*/i, (msg) ->
    msg.send "(mboy) Coffee? You live in Austin! https://scontent-b.xx.fbcdn.net/hphotos-prn2/t1.0-9/10325194_10152473938621742_3748103880787422234_n.jpg"

  #####
  # mBoy Alias'
  robot.hear /@DEV/i, (msg) ->
    msg.send "(mboy) Hey @fleeting, @PeteGautier, @higley, @john, and @JessicaCanales, #{msg.message.user.name} has summoned you."

  robot.hear /@DESIGN/i, (msg) ->
    msg.send "(mboy) Hey @nikki, @steph, and @autumn, #{msg.message.user.name} has summoned you."

  robot.hear /@MARKETING/i, (msg) ->
    msg.send "(mboy) Hey @JoePickerill, @AdamLefton, and @AlexisKraus, #{msg.message.user.name} has summoned you."

  robot.hear /@MGMT/i, (msg) ->
    msg.send "(mboy) Hey @MrNiceGuy, @JoePickerill, and @AndreaTucker, #{msg.message.user.name} has summoned you."
  #####

  #####
  # The Great Dish Etiquette of 2015
  kitchen_memes = [
    "http://makeameme.org/media/created/YEAH-if-you-aujh53.jpg",
    "http://m.memegen.com/83zm2s.jpg",
    "http://www.quickmeme.com/img/c8/c8e2da6a84bd0f862c9135b59ac7b758bae8b587d3bf042820de2334dd2f822d.jpg"
  ]

  robot.hear /.*(dirtykitchen).*/i, (msg) ->
    robot.messageRoom("113009_monkee-boy@conf.hipchat.com", "Come on Monkees, we don't actually live in the jungle. I've found that somebody has violated The Great Dish Etiquette of 2015. You know who you are so there is no need to call you out. Just take care of it. "+kitchen_memes[Math.floor(Math.random()*kitchen_memes.length)]);
  #####

  # robot.hear /ANDREA/i, (msg) ->
  #   msg.send "(mboy) Aww, I miss Andrea. (grumpycat)"

  # TODO: Need to solve a few issues with these calling more than they should.
  # robot.enter (msg) ->
  #   msg.send "Hey #{msg.message.user.name}, welcome to the jungle."  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
  #
  # robot.leave (msg) ->
  #   msg.send "Aww, I'm going to miss #{msg.message.user.name}. (okay)"  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
