extends Node2D

@onready var _pipes: Array = [$Pipe1, $Pipe2]
@onready var _bird: Bird = $Bird
@onready var _score_label: Label = $Control/ScoreLabel

func _ready():
	for pipe in _pipes:
		pipe.set_random_y()

func _physics_process(_delta: float):
	if Globals.is_ready():
		if Input.is_action_just_pressed("tap"):
			Globals.play()
	elif Globals.is_lost():
		if _bird.position.y >= Globals.GROUND_Y and Input.is_action_just_pressed("tap"):
			reset()

func reset():
	for pipe in _pipes:
		pipe.reset()
	_bird.reset()
	Globals.reset()
	_score_label.text = "0"

func _on_bird_scored():
	Globals.score += 1
	_score_label.text = str(Globals.score)
