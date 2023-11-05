extends StaticBody2D

signal on_player_enter

@export var is_opened: bool = false
@export var is_locked: bool = false


func _ready():
	if is_opened:
		$AnimatedSprite2D.frame = 2
	else:
		$AnimatedSprite2D.frame = 0


func unlock():
	is_locked = false


func _on_body_entered_in_sensor(body):
	if body is PlayablePlayer:
		on_player_enter.emit()
		if !is_locked:
			$AnimatedSprite2D.play()


func _on_body_exited_the_sensor(body):
	if body is PlayablePlayer:
		if !is_locked:
			$AnimatedSprite2D.play_backwards()


func _on_animated_sprite_2d_animation_finished():
	is_opened = !is_opened
	$CollisionShape2D_closed.disabled = is_opened

