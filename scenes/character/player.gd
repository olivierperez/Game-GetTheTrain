extends CharacterBody2D

class_name PlayablePlayer


@export var speed = 300
var direction: Vector2 = Vector2.ZERO :
	get:
		return direction
	set(value):
		direction = value
		facing = value
		_update_animation()

var facing = Vector2.DOWN


func _physics_process(__):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if get_real_velocity() == Vector2.ZERO:
		direction = Vector2.ZERO


func _update_animation():
	var direction_name = _get_direction_name()
	if (direction_name == ""):
		$AnimatedSprite2D.stop()
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

