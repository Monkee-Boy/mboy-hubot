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
  robot.hear /.*(coffee me).*/i, (msg) ->
    msg.send ":monkee: Coffee? You live in Austin! https://scontent-b.xx.fbcdn.net/hphotos-prn2/t1.0-9/10325194_10152473938621742_3748103880787422234_n.jpg"

  #####
  # The Great Dish Etiquette of 2015
  kitchen_memes = [
    "http://makeameme.org/media/created/YEAH-if-you-aujh53.jpg",
    "http://m.memegen.com/83zm2s.jpg",
    "http://www.quickmeme.com/img/c8/c8e2da6a84bd0f862c9135b59ac7b758bae8b587d3bf042820de2334dd2f822d.jpg"
  ]

  robot.hear /.*(dirtykitchen).*/i, (msg) ->
    robot.send room: 'mbot-playground', "Come on Monkees, we don't actually live in the jungle. I've found that somebody has violated The Great Dish Etiquette of 2015. You know who you are so there is no need to call you out. Just take care of it. "+kitchen_memes[Math.floor(Math.random()*kitchen_memes.length)]
  #####
  
  # TODO: Need to solve a few issues with these calling more than they should.
  # robot.enter (msg) ->
  #   msg.send "Hey #{msg.message.user.name}, welcome to the jungle."  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
  #
  # robot.leave (msg) ->
  #   msg.send "Aww, I'm going to miss #{msg.message.user.name}. (okay)"  if msg.message.user.room is "113009_mbot_playground@conf.hipchat.com"
