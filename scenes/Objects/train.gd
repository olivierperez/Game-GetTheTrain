extends Node2D
class_name Train

signal on_locomotive_entered
signal on_wagons_entered


func _on_locomotive_area_body_entered(body):
	print("loco entered", body)
	if body is PlayablePlayer:
		on_locomotive_entered.emit()


func _on_wagons_area_body_entered(body):
	print("wagons entered", body)
	if body is PlayablePlayer:
		on_wagons_entered.emit()
