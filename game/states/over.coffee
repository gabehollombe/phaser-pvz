module.exports =
  init: ->

  create: ->

  update: ->
    text = @game.add.text @game.world.width / 2, @game.world.height / 2, "The Zombies ate your Brains!\nTap to Start.", { font: '20px sans-serif', fill: '#FFF' }
    text.anchor.setTo 0.5, 0.5
    @game.input.onTap.add =>
      @game.state.start 'Play'
