extends Node2D


var has_ticket: bool = false


func _ready():
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/levels/level_002/level_002.dialogue"),
		"start"
	)


func appear():
	%Player.visible = true

func buy_ticket():
	has_ticket = true
	%TicketAudio.play(0.5)


func play_machine_hs():
	%MachineHS.play()


func train_departure():
	%Train.leave()
	%Player.visible = false
	%Player.disable()


func finish():
		get_tree().change_scene_to_file("res://scenes/levels/finish.tscn")
