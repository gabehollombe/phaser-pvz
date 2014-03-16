Game = { States: require './states/index.coffee' }

window.game = game = new Phaser.Game(
  490
  290
  Phaser.AUTO
  '' # Don't attach to an existing DOM element
)

game.state.add('Boot', Game.States.Boot)
game.state.add('Title', Game.States.Title)
game.state.add('Play', Game.States.Play)
game.state.add('Over', Game.States.Over)

game.state.start 'Boot'
