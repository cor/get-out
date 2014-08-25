var game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update });

function preload() {
    game.load.image("tile", "img/tile.png");
    game.load.image("ball", "img/ball.png");
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
    cursors = game.input.keyboard.createCursorKeys();


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
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, "UP");
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }

    if (cursors.down.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, "DOWN");
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }

    if (cursors.right.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, "RIGHT");
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }

    if (cursors.left.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, "LEFT");
            lastMoveTimestamp = game.time.now + MOVE_DELAY
        }
    }
}

/**
 * Moves sprite in grid
 *
 * @param sprite the sprite you want to move
 * @param direction{string} UP, DOWN, LEFT, RIGHT
 */
function moveSpriteInGrid(sprite, direction) {

    switch (direction) {
        case "UP":
            sprite.y -= TILE_HEIGHT;
            break;
        case "DOWN":
            sprite.y += TILE_HEIGHT;
            break;
        case "LEFT":
            sprite.x -= TILE_WIDTH;
            break;
        case "RIGHT":
            sprite.x += TILE_WIDTH;
            break;
        default:
            alert("ERROR: Invalid direction at moveSpriteInGrid()");
            break;
    }

}

