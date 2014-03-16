Pea = require './pea.coffee'

module.exports = class Plant
  constructor: (@state, position) ->
    @game = state.game
    cell = @state.getCellOrigin(position.x, position.y)
    @row = @state.rowForY(cell.y)
    @col = @state.colForX(cell.x)

    sprite = @game.plants.create cell.x, cell.y + 10, 'sprites', 'ps-idle01.png'

    shoot = sprite.animations.add 'shoot', ["ps-shoot1.png", "ps-shoot2.png"], 5, false, false
    shoot.onComplete.add (-> @animations.play 'idle'), sprite

    idle = sprite.animations.add 'idle', ["ps-idle01.png"], 1, false, false
    sprite.animations.play 'idle'

    @sprite = sprite
    sprite.plant = this
    sprite.update = @update

  update: =>
    @shoot() if @zombieAhead() and @canShoot()

  row: @row
  col: @col

  lastShotAt: 0

  firingRate: 1 * 1000

  zombieAhead: ->
    ahead = (sprite for sprite in @state.game.zombies.children when sprite.zombie.row == @row and sprite.position.x > @sprite.position.x).length > 0

  canShoot: ->
    @timeSinceLastShot() > @firingRate

  timeSinceLastShot: ->
    new Date().getTime() - @lastShotAt

  shoot: ->
    @lastShotAt = new Date().getTime()
    @sprite.animations.play 'shoot'
    @game.audio.pea_shoot.play()
    new Pea @game, new Phaser.Point(@sprite.position.x + 10, @sprite.position.y)
