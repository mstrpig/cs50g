# Pong

A small implementation of the classic Pong game in Lua + LÖVE2D.

## About the Game

- Two-player game
- Classic gameplay
- First to 3 points wins

## Requirements

- [LÖVE](https://love2d.org/) version 11.x

## Running

### Windows

1. Install LÖVE 11.x.
2. Open a terminal in the project folder.
3. Run:

```bash
love .
```

Alternative: drag the project folder onto `love.exe`.

## Controls

- Player 1: `W` / `S`
- Player 2: `↑` / `↓`
- Start / continue / restart after win: `Enter`
- Exit: `Esc`

## Project Structure

- `main.lua` — game loop, states, rendering, input handling
- `constants.lua` — all core constants
- `Ball.lua` — ball: movement, collisions, rendering
- `Paddle.lua` — paddle: movement, rendering
- `class.lua` — minimalist class system
- `push.lua` — virtual resolution library
- `font.ttf` — UI font

## Configuration

The main tuning parameters are in `constants.lua`:

- `PADDLE_SPEED`
- `PADDLE_SPEED_MULTIPLIER`
- `BALL_SIZE`
- `WIN_SCORE`
- `WINDOW_WIDTH` / `WINDOW_HEIGHT`
- `VIRTUAL_WIDTH` / `VIRTUAL_HEIGHT`

## Author

Maria Striletska