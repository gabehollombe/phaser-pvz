module.exports = class Zombie extends Phaser.Sprite
  constructor: (@state) ->
    @game = state.game

    row = @game.rnd.integerInRange(0, 6)
    x = @game.world.width
    y = @state.yForRow(row)
    @row = row

    sprite = @game.zombies.create x, y, 'sprites', 'zombie1.png'
    sprite.animations.add 'walking', ["zombie1.png","zombie2.png", "zombie3.png"], 5, true, false
    sprite.animations.play 'walking'

    sprite.body.velocity.setTo -20, 0
    sprite.health = 5
    sprite.events.onKilled.add (-> @destroy()), sprite

    sprite.checkWorldBounds = true

    sprite.events.onOutOfBounds.add (->
      @game.state.start 'Over'
    ), sprite

    sprite.zombie = this
    @sprite = sprite
