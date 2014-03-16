module.exports =
  preload: ->
    @game.load.atlasJSONHash 'sprites', "assets/sprites.png", "assets/sprites.json"
    @game.load.image 'grass', 'assets/newgrass7x12_small.png'
    @game.load.audio('peaShoot', ['assets/audio/effects/pea_shoot.mp3', 'assets/audio/effects/pea_shoot.ogg'])
    @game.load.audio('splat', ['assets/audio/effects/splat.mp3', 'assets/audio/effects/splat.ogg'])
    @game.load.audio('zombiesAreComing', ['assets/audio/effects/zombies_are_coming.mp3', 'assets/audio/effects/zombies_are_coming.ogg'])

  init: ->
    @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    @game.scale.minWidth = 490
    @game.scale.minHeight = 290
    @game.scale.maxWidth = 980
    @game.scale.maxHeight = 580
    @game.scale.pageAlignHorizontally = true
    @game.scale.pageAlignVertically = true
    @game.scale.forceOrientation(true, false)
    @game.scale.setScreenSize(true)

    @game.input.maxPointers = 1

  create: ->
    @game.CELL_WIDTH = 490 / 12
    @game.CELL_HEIGHT = 290 / 7

    @game.state.start 'Title'
