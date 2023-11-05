extends StaticBody2D

signal on_player_open_machine
signal on_player_exit_machine


func _on_area_body_entered(body):
	if body is PlayablePlayer:
		on_player_open_machine.emit()


func _on_area_body_exited(body):
	if body is PlayablePlayer:
		on_player_exit_machine.emit()

