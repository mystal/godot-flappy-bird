extends CharacterBody2D
class_name Bird

const GRAVITY: float = 650.0
const MAX_FALL_SPEED: float = 400.0
const JUMP_SPEED: float = -230.0

const BIRD_RADIUS: float = 7.0

@onready var _sprite: AnimatedSprite2D = $Sprite
@onready var _start_position: Vector2 = position
@onready var _default_collision_layer: int = collision_layer
@onready var _default_collision_mask: int = collision_mask

func _ready():
	pass

func _physics_process(delta: float):
	if Globals.is_ready():
		velocity = Vector2.ZERO
	else:
		# Add gravity, clamping to MAX_FALL_SPEED.
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)

	# Handle Jump.
	if !Globals.is_lost() and Input.is_action_just_pressed("tap"):
		velocity.y = JUMP_SPEED

	move_and_slide()

	if Globals.is_playing() and get_last_slide_collision() != null:
		collision_layer = 0
		collision_mask = 0
		velocity = Vector2.ZERO
		_sprite.pause()

		Globals.lose()

	if position.y < BIRD_RADIUS:
		# Zero out velocity and clamp position if hitting the top of the screen.
		velocity.y = 0.0
		position.y = BIRD_RADIUS
	elif position.y > Globals.GROUND_Y:
		# Clamp position if hitting the ground. Should only happen when lost and collision is off.
		position.y = Globals.GROUND_Y

	if !Globals.is_ready():
		# Set sprite rotation based on speed.
		if velocity.y < 0.0:
			# Rotate left.
			_sprite.rotation_degrees -= 600.0 * delta
		elif velocity.y > 110.0:
			_sprite.rotation_degrees += 480.0 * delta
		_sprite.rotation_degrees = clamp(_sprite.rotation_degrees, -30.0, 90.0)

func reset():
	position = _start_position
	velocity = Vector2.ZERO
	_sprite.rotation_degrees = 0.0
	_sprite.play()
	collision_layer = _default_collision_layer
	collision_mask = _default_collision_mask
