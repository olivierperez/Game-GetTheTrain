extends StaticBody2D
class_name Train

signal on_locomotive_entered
signal on_wagons_entered

@export var leaving_destination: Node2D
@export var speed: int = 50

var is_leaving: bool = false


func _physics_process(delta):
	if is_leaving:
		position = position.move_toward(leaving_destination.position, delta * speed)


func _on_locomotive_area_body_entered(body):
	print("loco entered", body)
	if body is PlayablePlayer:
		on_locomotive_entered.emit()


func _on_wagons_area_body_entered(body):
	print("wagons entered", body)
	if body is PlayablePlayer:
		on_wagons_entered.emit()

func leave():
	$SmokeParticles.emitting = true
	is_leaving = true
