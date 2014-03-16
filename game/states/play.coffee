Zombie = require '../models/zombie.coffee'
Plant = require '../models/plant.coffee'

module.exports =
  init: ->
    @game.input.onTap.add =>
      @handleTap(@game.input.activePointer)

  create: ->
    @game.world.setBounds(0, 0, @game.world.width, @game.world.height)

    @game.add.image 0, 0, 'grass'

    @game.plants = @game.add.physicsGroup(Phaser.Physics.ARCADE, @game.world, 'plants')
    @game.projectiles = @game.add.physicsGroup(Phaser.Physics.ARCADE, @game.world, 'projectiles')
    @game.zombies = @game.add.physicsGroup(Phaser.Physics.ARCADE, @game.world, 'zombies')

    @game.time.events.repeat 3 * 1000, 9999, (-> new Zombie(this)), this

    @game.audio = {}
    @game.audio.pea_shoot = @game.add.audio('peaShoot')
    @game.audio.splat = @game.add.audio('splat')
    @game.audio.zombiesAreComing = @game.add.audio('zombiesAreComing')

    @game.audio.zombiesAreComing.play()

  update: ->
   @game.physics.arcade.overlap @game.projectiles, @game.zombies, @handleZombieHit, null, this

  handleZombieHit: (projectile, zombie) ->
    @game.audio.splat.play()
    zombie.damage(1)
    projectile.kill()

  handleTap: (pointer) ->
    cell = @getCellOrigin(pointer.x, pointer.y)
    row = @rowForY(cell.y)
    col = @colForX(cell.x)
    new Plant(this, @game.input.activePointer.position) if not @plantAt(row, col)

  plantAt: (row, col) ->
    (plant for plant in @game.plants.children when plant.row == row and plant.col == col)[0]

  getCellOrigin: (x, y) ->
    x: Math.floor(x / @game.CELL_WIDTH) * @game.CELL_WIDTH + 10
    y: Math.floor(y / @game.CELL_HEIGHT) * @game.CELL_HEIGHT

  colForX: (x) ->
    x / @game.CELL_WIDTH

  rowForY: (y) ->
    y / @game.CELL_HEIGHT

  yForRow: (row) ->
    return 0 if row == 0
    return 35 + (row - 1) * 41
