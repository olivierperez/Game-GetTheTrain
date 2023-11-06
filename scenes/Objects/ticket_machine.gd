extends StaticBody2D

signal on_player_open_machine
signal on_player_exit_machine

enum Config {
	WORKING,
	BROKEN
}


@export var config: Config = Config.WORKING
@export var hud: HUD


func _on_area_body_entered(body):
	if body is PlayablePlayer:
		_on_player_entered()


func _on_area_body_exited(body):
	if body is PlayablePlayer:
		on_player_exit_machine.emit()


func _on_player_entered():
	match config:
		Config.WORKING:
			on_player_open_machine.emit()
		Config.BROKEN:
			$MachineHS.play()
			hud.show_message(
				"Cette machine semble hors service, c'est étonnant.",
				"Arf!"
			)
