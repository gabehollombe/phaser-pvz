module.exports = class Pea extends Phaser.Sprite
  constructor: (@game, position) ->
    sprite = @game.projectiles.create position.x, position.y, 'sprites', 'pea.png'
    sprite.body.velocity.setTo 150, 0
    sprite.checkWorldBounds = true
    sprite.outOfBoundsKill = true

    @sprite = sprite
    sprite.pea = this
