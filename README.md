# Monkee Bot

Say hello to ![MBoy](https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/113009/mboy-1403300528.jpg) **MBot**, your friendly neighborhood monkee robot. A brother to [hubot](https://hubot.github.com/), he currently lives high up in the tree tops of Heroku and stays busy in the [@monkee-boy](http://github.com/monkee-boy/) HipChat server. He enjoys creating memes, sharing his knowledge of cats, monitoring twitter for mentions of MBoy, and serving up beer when needed.

---

### Testing Hubot Locally

You can test your hubot by running the following.

    % bin/hubot

You'll see some start up output about where your scripts come from and a
prompt.

    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading adapter shell
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/scripts
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/src/scripts
    Hubot>

Then you can interact with hubot by typing `hubot help`.

    Hubot> hubot help

    Hubot> animate me <query> - The same thing as `image me`, except adds a few
    convert me <expression> to <units> - Convert expression to given units.
    help - Displays all of the help commands that Hubot knows about.
    ...


### Scripting

Take a look at the scripts in the `./scripts` folder for examples. Read up on what you can do with hubot in the [Scripting Guide](https://github.com/github/hubot/blob/master/docs/scripting.md).

## Deployment

    % heroku create --stack cedar
    % git push heroku master
    % heroku ps:scale app=1

If your Heroku account has been verified you can run the following to enable
and add the Redis to Go addon to your app.

    % heroku addons:add redistogo:nano

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

You'll need to edit the `Procfile` to set the name of your hubot.

More detailed documentation can be found on the
[deploying hubot onto Heroku][deploy-heroku] wiki page.

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.
