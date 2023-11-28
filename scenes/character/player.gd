extends CharacterBody2D

class_name PlayablePlayer

@export var speed = 250
@export var gravity = 40.0
@export var jump_force = 10

var state: State = State.IDLE
var direction: Vector2 = Vector2.ZERO :
	get:
		return direction
	set(value):
		direction = value
		facing = value
		_update_animation()

var facing: Vector2 = Vector2.DOWN
var disabled: bool = false

@export var vertical_velocity: float = 0
@export var vertical_position: float = 0

enum State { IDLE, RUNNING, JUMPING }

func _physics_process(delta):
	if disabled:
		return

	if Input.is_action_just_pressed("jump") && state != State.JUMPING:
		_start_jumping()

	match(state):
		State.IDLE:
			_process_idle(delta)
		State.RUNNING:
			_process_running(delta)
		State.JUMPING:
			_process_jumping(delta)

	move_and_slide()

	if get_real_velocity() == Vector2.ZERO:
		direction = Vector2.ZERO


func _start_jumping():
	vertical_velocity = -jump_force
	state = State.JUMPING
	_update_animation()


func _process_idle(__):
	_process_direction_change()


func _process_running(__):
	_process_direction_change()


func _process_jumping(delta):
	vertical_velocity += gravity * delta
	vertical_position += vertical_velocity
	var jump_percent = vertical_position / -70
	$AnimatedSprite2D.scale = Vector2(1 + 0.3 * jump_percent, 1 + 0.3 * jump_percent)

	if vertical_position >= 0:
		vertical_velocity = 0
		vertical_position = 0
		$AnimatedSprite2D.scale = Vector2(1, 1)
		if direction != Vector2.ZERO:
			state = State.RUNNING
		else:
			state = State.IDLE


func _process_direction_change():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed


func disable():
	disabled = true
	$AnimatedSprite2D.stop()


func enable():
	disabled = false


func _update_animation():
	var direction_name = _get_direction_name()

	if (direction_name == ""):
		$AnimatedSprite2D.stop()
	elif state == State.JUMPING:
		$AnimatedSprite2D.animation = "Move" + direction_name
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
	else:
		$AnimatedSprite2D.animation = "Move" + direction_name
		$AnimatedSprite2D.play()


func _get_direction_name() -> String:
	if direction.y < 0:
		return "Up"
	elif direction.y > 0:
		return "Down"
	elif direction.x > 0:
		return "Right"
	elif direction.x < 0:
		return "Left"
	else:
		return ""

