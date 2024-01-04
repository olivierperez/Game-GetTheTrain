extends StaticBody2D
class_name Train

signal on_locomotive_entered
signal on_wagons_entered
signal on_train_arrived

@export var leaving_destination: Node2D
@export var arriving_destination: Node2D
@export var speed: int = 50

var is_leaving: bool = false
var is_arriving: bool = false


func _physics_process(delta):
	if is_arriving:
		position = position.move_toward(arriving_destination.position, delta * speed)
		var distance_to_arrival = (position - arriving_destination.position).length()
		if (distance_to_arrival < 1):
			_on_arrival()
	elif is_leaving:
		position = position.move_toward(leaving_destination.position, delta * speed)


func _on_locomotive_area_body_entered(body):
	if body is PlayablePlayer:
		on_locomotive_entered.emit()


func _on_wagons_area_body_entered(body):
	if body is PlayablePlayer:
		on_wagons_entered.emit()


func arrive():
	$SmokeParticles.emitting = true
	is_arriving = true


func leave():
	$SmokeParticles.emitting = true
	is_leaving = true


func _on_arrival():
	is_arriving = false
	$SmokeParticles.emitting = false
	on_train_arrived.emit()
