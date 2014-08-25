var game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update });

function preload() {
    game.load.image("ground", "img/ground.png")
}
var GROUND_WIDTH = 16;
var GROUND_HEIGHT = 16;

function create() {

    ground = game.add.group();

    for (i = 0; i < GROUND_WIDTH; i++) {
        for (j = 0; j < GROUND_HEIGHT; j++) {
            ground.create(i * 32, j * 32, "ground");
        }
    }

}

function update() {

}