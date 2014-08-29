var TILE_HEIGHT = 32;
var TILE_WIDTH = 32;

var LEVEL_WIDTH = 16;
var LEVEL_HEIGHT = 16;

var TileEnum = {
    None : 0,
    Ground : 1,
    Button : 2
};

var game = new Phaser.Game((LEVEL_WIDTH * TILE_WIDTH), (LEVEL_HEIGHT * TILE_HEIGHT), Phaser.AUTO, '', { preload: preload, create: create, update: update });

var MOVE_DELAY = 200;
var BALL_EASING = Phaser.Easing.Cubic.InOut;



var level = [];

var ball;
var cursors;
var lastMoveTimestamp = 0;

function preload() {
    game.load.image("tile", "img/tile.png");
    game.load.image("ball", "img/ball.png");
    game.load.image("button_on", "img/button_on.png");
}

function create() {

    generateLevel();
    level[4][5] = TileEnum.Button;
    renderLevel();

    //input
    cursors = game.input.keyboard.createCursorKeys();

    //game objects
    ball = game.add.sprite(32, 32, "ball");
    ball.gridPosition = new Phaser.Point(1,1);
    ball.tilesPerMove = 1;
}

function update() {
    if (cursors.up.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, new Phaser.Point(0, -ball.tilesPerMove));
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }

    if (cursors.down.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, new Phaser.Point(0, ball.tilesPerMove));
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }

    if (cursors.right.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, new Phaser.Point(ball.tilesPerMove, 0));
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }

    if (cursors.left.isDown) {
        if (game.time.now > lastMoveTimestamp) {
            moveSpriteInGrid(ball, new Phaser.Point(-ball.tilesPerMove, 0));
            lastMoveTimestamp = game.time.now + MOVE_DELAY;
        }
    }
}

/**
 * Move a sprite in the grid
 * @param sprite {Phaser.Sprite} the sprite you want to move
 * @param vector {Phaser.Point} the move vector
 */
function moveSpriteInGrid(sprite, vector) {
    if (gridPositionIsValid(sprite.gridPosition.x + vector.x, sprite.gridPosition.y + vector.y)) {
        sprite.gridPosition.x += vector.x;
        sprite.gridPosition.y += vector.y;
        game.add.tween(sprite).to({x: sprite.gridPosition.x * TILE_WIDTH, y: sprite.gridPosition.y * TILE_HEIGHT}, MOVE_DELAY, BALL_EASING, true);
    }
}

/**
 * Check if gridPosition is valid (ie, on the grid)
 * @param x {Number} x position
 * @param y {Number} y position
 * @returns {boolean}
 */
function gridPositionIsValid(x, y) {

    return !(x >= LEVEL_WIDTH || x < 0 || y >= LEVEL_HEIGHT || y < 0);
}


/**
 * Generates level and stores it in the 2D Array level
 */
function generateLevel() {
    for (var i = 0; i < LEVEL_HEIGHT; i++) {
        var levelRow = [];
        for (var j = 0; j < LEVEL_WIDTH; j++) {
            levelRow[j] = TileEnum.Ground;
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
                case TileEnum.Ground:
                    ground.create(j * TILE_WIDTH, i * TILE_HEIGHT, "tile");
                    break;
                case TileEnum.Button:
                    ground.create(j * TILE_WIDTH, i * TILE_HEIGHT, "button_on");
                    break;
                default :
                    alert("ERROR | INVALID level[][] value");
                    break;
            }
        }
    }
}

/**
 * @param point {Phaser.Point} gridPosition
 * @returns {TileEnum}
 */
function getTileAtPoint(point) {
    return level[point.x][point.y];
}

/**
 * @param point {Phaser.Point} gridPosition
 * @param tile {TileEnum}
 */
function setTileAtPoint(point, tile) {
    level[point.x][point.y] = tile;
}
