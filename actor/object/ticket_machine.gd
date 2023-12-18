extends StaticBody2D

signal on_player_open_machine

enum Config {
	WORKING,
	BROKEN
}


@export var config: Config = Config.WORKING


func _on_area_body_entered(body):
	if body is PlayablePlayer:
		_on_player_entered()


func _on_player_entered():
	match config:
		Config.WORKING:
			on_player_open_machine.emit()
		Config.BROKEN:
			$MachineHS.play()
