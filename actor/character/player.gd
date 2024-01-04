extends CharacterBody2D

class_name PlayablePlayer

@export var speed = 250
@export var gravity = 40.0
@export var jump_force = 10
@export var vertical_velocity: float = 0
@export var vertical_position: float = 0
@export var initial_orientation: Vector2 = Vector2.UP

@onready var actionable_finder = %ActionableFinder
@onready var direction_node = %Direction

var state: State = State.IDLE :
	get:
		return state
	set(value):
		state = value
		_update_collision()

var direction: Vector2 = Vector2.ZERO :
	get:
		return direction
	set(value):
		if direction != value:
			direction = value
			facing = value
			_update_animation()
			_update_actionable_finder()

var facing: Vector2 = Vector2.DOWN # Variable useless?
var disabled: bool = false

enum State { IDLE, RUNNING, JUMPING }


func _ready():
	direction = initial_orientation
	disabled = !visible


func _unhandled_input(event):
	if disabled:
		return

	if Input.is_action_just_pressed("action"):
		_on_action()

	if Input.is_action_just_pressed("jump") && state != State.JUMPING:
		_start_jumping()

	match(state):
		State.IDLE:
			_process_idle()
		State.RUNNING:
			_process_running()


func _physics_process(delta):
	if disabled:
		return

	match(state):
		State.JUMPING:
			_process_jumping(delta)

	move_and_slide()

	if get_real_velocity() == Vector2.ZERO:
		direction = Vector2.ZERO


func _on_action():
	var actionnables = actionable_finder.get_overlapping_areas()
	if actionnables.size() > 0:
		actionnables[0].action()


func _start_jumping():
	vertical_velocity = -jump_force
	state = State.JUMPING
	_update_animation()


func _process_idle():
	_detect_direction_change()
	_apply_velocity()


func _process_running():
	_detect_direction_change()
	_apply_velocity()


func _process_jumping(delta):
	vertical_velocity += gravity * delta
	vertical_position += vertical_velocity
	var jump_percent = vertical_position / -70
	$AnimatedSprite2D.scale = Vector2(1 + 0.3 * jump_percent, 1 + 0.3 * jump_percent)

	if vertical_position >= 0:
		if direction != Vector2.ZERO:
			state = State.RUNNING
		else:
			state = State.IDLE

		vertical_velocity = 0
		vertical_position = 0
		$AnimatedSprite2D.scale = Vector2(1, 1)
		_detect_direction_change()
		_apply_velocity()
		_update_animation()


func _detect_direction_change():
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")


func _apply_velocity():
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

func _update_actionable_finder():
	if direction == Vector2.RIGHT:
		direction_node.rotation = deg_to_rad(90)
	elif direction == Vector2.LEFT:
		direction_node.rotation = deg_to_rad(-90)
	elif direction == Vector2.DOWN:
		direction_node.rotation = deg_to_rad(180)
	elif direction == Vector2.UP:
		direction_node.rotation = 0


func _update_collision():
	if (state == State.JUMPING):
		set_collision_mask_value(2, false)
	else:
		set_collision_mask_value(2, true)


func _get_direction_name() -> String:
	if direction.y < -0.1:
		return "Up"
	elif direction.y > 0.1:
		return "Down"
	elif direction.x > 0.1:
		return "Right"
	elif direction.x < -0.1:
		return "Left"
	else:
		return ""
