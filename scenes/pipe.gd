class_name Pipe
extends AnimatableBody2D

const PIPE_SPEED: float = 80.0
const PIPE_END_X: float = -30.0
const PIPE_START_X: float = 210.0

@onready var _start_x: float = position.x

func _physics_process(delta: float):
	if Globals.game_state != Globals.GameState.Playing:
		return

	move_and_collide(Vector2(-PIPE_SPEED * delta, 0.0))

	if position.x < PIPE_END_X:
		position.x = PIPE_START_X
		set_random_y()

func reset():
	position.x = _start_x
	set_random_y()

func set_random_y():
	position.y = Globals.gen_random_pipe_y()
