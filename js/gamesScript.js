var game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update });

function preload() {
    game.load.image("tile", "img/tile.png");
    game.load.image("ball", "img/ball.png");
}
var LEVEL_WIDTH = 16;
var LEVEL_HEIGHT = 16;

var TILE_HEIGHT = 32;
var TILE_WIDTH = 32;

var MOVE_DELAY = 200;

var level = [];


var ball;
var cursors;
var lastMoveTimestamp = 0;


function create() {

    generateLevel();
    renderLevel();

    //input
    cursors = game.input.keyboard.createCursorKeys();



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
 * @param direction{String} UP, DOWN, LEFT, RIGHT
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
/**
 * Generates level and stores it in the 2D Array level
 */
function generateLevel() {
    for (var i = 0; i < LEVEL_HEIGHT; i++) {
        var levelRow = [];
        for (var j = 0; j < LEVEL_WIDTH; j++) {
            levelRow[j]=0;
        }
        level[i]=levelRow;
    }
}

/**
 * creates tiles for each number in the 2D Array level
 */
function renderLevel() {
    var ground = game.add.group();

    for (var i = 0; i < level.length; i++) {
        for (var j = 0; j < level[i].length; j++) {
            switch (level[i][j]) {
                case 0:
                    ground.create(j * TILE_WIDTH, i * TILE_HEIGHT, "tile");
                    break;
                default :
                    alert("ERROR | INVALID level[][] value");
                    break;
            }
        }
    }
}

