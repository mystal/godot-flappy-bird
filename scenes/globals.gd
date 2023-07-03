extends Node2D

enum GameState {
    Ready,
    Playing,
    Lost,
}

# TODO: Can we compute these instead of hard-coding?
const GAME_SIZE: Vector2 = Vector2(180.0, 320.0)
const GROUND_Y = 256.0
const PIPE_GAP: float = 70.0
const PIPE_Y_RAND_RANGE: float = 60.0

var game_state: GameState = GameState.Ready
var score: int = 0
var last_pipe_y: float = GAME_SIZE.y / 2.0

func gen_random_pipe_y() -> float:
    # Top of screen plus some buffer room.
    const MIN: float = PIPE_GAP * 0.75
    # Top of ground minus some buffer room.
    const MAX: float = GROUND_Y - (PIPE_GAP * 0.75)

    var range_min: float = max(last_pipe_y - PIPE_Y_RAND_RANGE, MIN)
    var range_max: float = min(last_pipe_y + PIPE_Y_RAND_RANGE, MAX)

    last_pipe_y = roundf(randf_range(range_min, range_max))
    return last_pipe_y

func is_ready() -> bool:
    return game_state == GameState.Ready

func is_playing() -> bool:
    return game_state == GameState.Playing

func is_lost() -> bool:
    return game_state == GameState.Lost

func reset():
    game_state = GameState.Ready
    score = 0
    last_pipe_y = GAME_SIZE.y / 2.0

func play():
    game_state = GameState.Playing

func lose():
    game_state = GameState.Lost
    print("LOSE")
