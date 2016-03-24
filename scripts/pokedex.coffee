# Description
#   A wild Hubot appears. Hubot uses Pokédex.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   pokedex help - A quick list of the commands available.
#   pokedex select <PokemonName> - Query the Pokédex for information about a Pokémon.
#   pokedex select random - Query the Pokédex for information about a random Pokémon.
#
# Notes:
#
#
# Author:
#   James Fleeting <hello@jamesfleeting.com>

module.exports = (robot) ->
  getPokemon = (pokemon, cb) ->
    robot.http("http://pokeapi.co/api/v2/pokemon/" + pokemon + "/").header('Content-Type', 'application/json').get() (err, res, body) ->
      if err
        robot.send "Encountered an error :( #{err}"
        return

      robot.logger.debug "/pokemon/#{pokemon}/ - #{body}"
      pokemon = JSON.parse body

      getPokemonSpecies pokemon.id, (pokemon_species) ->
        pokemon.species = pokemon_species
        cb pokemon

  getPokemonSpecies = (pokemon_id, cb) ->
    robot.http("http://pokeapi.co/api/v2/pokemon-species/" + pokemon_id + "/").header('Content-Type', 'application/json').get() (err, res, body) ->
      if err
        robot.send "Encountered an error :( #{err}"
        return

      robot.logger.debug "/pokemon-species/#{pokemon_id}/ - #{body}"
      pokemon_species = JSON.parse body

      cb pokemon_species

  robot.hear /^pokemon ?$/im, (res) ->
    res.reply "I wanna be the very best\n
    Like no one ever was\n
    To catch them is my real test\n
    To train them is my cause\n

    I will travel across the land\n
    Searching far and wide\n
    Teach Pokémon to understand\n
    The power that's inside\n

    Pokémon (Gotta catch 'em all), it's you and me\n
    I know it's my destiny\n
    (Pokémon!)\n
    Ooh, you're my best friend\n
    In a world we must defend\n
    Pokémon (Gotta catch 'em all), a heart so true\n
    Our courage will pull us through\n
    You teach me, and I'll teach you\n
    Po-ké-mon\n
    (Gotta catch 'em all!)\n
    Gotta catch 'em all!\n
    Pokémon!"

  robot.hear /pokedex (.*) (.*)/i, (msg) ->
    action = msg.match[1].toLowerCase()
    query = msg.match[2].toLowerCase()
    pokemon = {}
    robot.logger.debug "Action is #{action} with a query of #{query}. The full message was #{msg}."

    if action == 'select'
      # Get data about a Pokémon from the Pokédex.
      msg.send "Give me a second to query the Pokédex."

      pokedex_storage = robot.brain.data.pokedex ||= {
        pokemon: {}
      }

      if typeof pokedex_storage.pokemon[query] != "undefined" && typeof query != "number"
        robot.logger.debug "Pokemon is being pulled from the cache."
        pokemon = pokedex_storage.pokemon[query]

        # TODO: Need to DRY this up (see else for second set).
        pokemon_type = ""
        pokemon.types.forEach (item, index, array) ->
          if index != 0
            pokemon_type += ", "

          pokemon_type += item.type.name
          return

        pokemon_stats = "The base stats are "
        pokemon.stats.forEach (item, index, array) ->
          if index != 0
            pokemon_stats += ", "

          pokemon_stats += "#{item.stat.name} #{item.base_stat}"
          return

        pokemon_abilities = "Abilities include "
        pokemon.abilities.forEach (item, index, array) ->
          if index != 0
            pokemon_abilities += ", "

          if item.ability.is_hidden
            hidden_ability = " (hidden)"
          else
            hidden_ability = ""

          pokemon_abilities += "#{item.ability.name}#{hidden_ability}"
          return

        if pokemon.species.evolves_from_species
          evolves_from = "It evolves from #{pokemon.species.evolves_from_species.name}."
        else
          evolves_from = "It does not evolve from another Pokemon."

        pokedex_entry = pokemon.species.flavor_text_entries[1].flavor_text.replace(/\r?\n|\r/g, ' ')

        msg.send "You've found #{pokemon.name}; a #{pokemon_type} type Pokémon. #{pokedex_entry} #{pokemon_stats}. #{pokemon_abilities}. #{evolves_from}"
      else
        # Generate a random Pokemon ID.
        if query == 'random'
          # Hardcoded the total number of Pokemon for now. I can get this info from the API if I want with http://pokeapi.co/api/v2/pokemon-species/?limit=0.
          query = Math.floor(Math.random() * (721 - 1 + 1)) + 1
          robot.logger.debug "Query has been updated for random with the ID of #{query}."

        robot.logger.debug "Pokemon is being pulled from the API."
        getPokemon query, (result) ->
          # Cache Pokemon in redis by name.
          # TODO: See if there is any data I don't need to store so the cache doesn't have everything.
          pokemon = result
          pokedex_storage.pokemon[pokemon.name] = pokemon
          robot.brain.save()

          pokemon_type = ""
          pokemon.types.forEach (item, index, array) ->
            if index != 0
              pokemon_type += ", "

            pokemon_type += item.type.name
            return

          pokemon_stats = "The base stats are "
          pokemon.stats.forEach (item, index, array) ->
            if index != 0
              pokemon_stats += ", "

            pokemon_stats += "#{item.stat.name} #{item.base_stat}"
            return

          pokemon_abilities = "Abilities include "
          pokemon.abilities.forEach (item, index, array) ->
            if index != 0
              pokemon_abilities += ", "

            if item.ability.is_hidden
              hidden_ability = " (hidden)"
            else
              hidden_ability = ""

            pokemon_abilities += "#{item.ability.name}#{hidden_ability}"
            return

          if pokemon.species.evolves_from_species
            evolves_from = "It evolves from #{pokemon.species.evolves_from_species.name}."
          else
            evolves_from = "It does not evolve from another Pokemon."

          pokedex_entry = pokemon.species.flavor_text_entries[1].flavor_text.replace(/\r?\n|\r/g, ' ')

          msg.send "You've found #{pokemon.name}; a #{pokemon_type} type Pokémon. #{pokedex_entry} #{pokemon_stats}. #{pokemon_abilities}. #{evolves_from}"
    else
      msg.send "That isn't a valid Pokedéx command. For help try 'pokedex help'."

  robot.hear /^pokedex help ?$/im, (res) ->
    res.reply "The Pokédex is a digital encyclopedia created by Professor Oak as an invaluable tool to Trainers in the Pokémon world. It gives information about all Pokémon in the world that are contained in its database."
    res.send " * pokedex select <PokemonName>"
    res.send " * pokedex select random"
    res.send " * pokedex help"

  robot.hear /pokemon battle (.*)/i, (res) ->
    res.send "Pokémon battles are coming soon. Until then check out the Pokédex!"

    # Fleshing out initial storage of battle data and structure. All work in progress.
    #
    # @battle_storage = robot.brain.data.battles ||= { }
    #
    # user = res.message.user.name.toLowerCase()
    # battles = @battle_storage[user] ||= {
    #   stats: {
    #     wins: 0
    #     loses: 0
    #     streak: 0
    #     incomplete: 0
    #   }
    #   current: {}
    #   history: {}
    # }
    #
    # battles.history[] = {
    #   self: {
    #     pokemon: {
    #       name: ''
    #       level: ''
    #       stats: ''
    #       moves: {}
    #       abilities: {}
    #       item: ''
    #     }
    #   }
    #   trainer: {
    #     name: ''
    #     pokemon: {
    #       name: ''
    #       level: ''
    #       stats: ''
    #       moves: {}
    #       abilities: {}
    #       items: ''
    #     }
    #   }
    #   turns: {
    #     one: {
    #       person: '' # Who is taking the turn
    #       action: '' # Attack || Use
    #       move: '' # If action === attack
    #       item: '' # If action === use
    #       damage: '' # if move does damage
    #       heal: '' # if item heals
    #     }
    #   }
    #   winner: ''
    #   loser: ''
    #   location: '' # Randomly generated location from a game.
    #   next_turn: '' # When a battle isn't over for who goes next.
    #   completed: '' # True if a battle was ended naturally.
    #   started: ''
    #   ended: ''
    # }
    #
    # battles.wins = 2
    # battles.loses = 4
    # robot.brain.save()
