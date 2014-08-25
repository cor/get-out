var game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update });

function preload() {
    game.load.image("tile", "img/tile.png")
    game.load.image("ball", "img/ball.png")
}
var GROUND_WIDTH = 16;
var GROUND_HEIGHT = 16;
var TILE_HEIGHT = 32;
var TILE_WIDTH = 32;

var MOVE_DELAY = 200;



var ball;
var cursors;
var lastMoveTimestamp = 0;


function create() {

    //input
    cursors = game.input.keyboard.createCursorKeys()


    ground = game.add.group();

    // generate ground
    for (i = 0; i < GROUND_WIDTH; i++) {
        for (j = 0; j < GROUND_HEIGHT; j++) {
            ground.create(i * 32, j * 32, "tile");
        }
    }

    ball = game.add.sprite(32, 32, "ball")
}

function update() {
    if (cursors.up.isDown) {
        moveObjectInGrid(ball, "UP");
    }

    if (cursors.down.isDown) {
        moveObjectInGrid(ball, "DOWN");
    }

    if (cursors.right.isDown) {
        moveObjectInGrid(ball, "RIGHT");
    }

    if (cursors.left.isDown) {
        moveObjectInGrid(ball, "LEFT")
    }

}

/**
 * Moves
 *
 * @param object the object you want to move
 * @param direction UP, DOWN, LEFT, RIGHT
 */
function moveObjectInGrid(object, direction) {

    if (game.time.now > lastMoveTimestamp) {
        switch (direction) {
            case "UP":
                object.y -= TILE_HEIGHT;
                break;
            case "DOWN":
                object.y += TILE_HEIGHT;
                break;
            case "LEFT":
                object.x -= TILE_WIDTH;
                break;
            case "RIGHT":
                object.x += TILE_WIDTH;
                break;
            default:
                alert("ERROR: Invalid direction at moveObjectInGrid()");
                break;
        }

        lastMoveTimestamp = game.time.now + MOVE_DELAY;
    }
}

