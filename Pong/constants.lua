local constants = {
    WINDOW_WIDTH = 1024,
    WINDOW_HEIGHT = 768,

    VIRTUAL_WIDTH = 400,
    VIRTUAL_HEIGHT = 300,

    P1_START_Y_POS = 20,
    P2_START_Y_POS = 240,

    BALL_SIZE = 6,

    PADDLE_SPEED = 200,
    PADDLE_SPEED_MULTIPLIER = 1.03,
    PADDLE_WIDTH = 5,
    PADDLE_HEIGHT = 40,

    SCORE_PAUSE_DURATION = 0.5,

    WIN_SCORE = 3
}

constants.BALL_START_X_POS = constants.VIRTUAL_WIDTH / 2 - constants.BALL_SIZE / 2
constants.BALL_START_Y_POS = constants.VIRTUAL_HEIGHT / 2 - constants.BALL_SIZE / 2

return constants