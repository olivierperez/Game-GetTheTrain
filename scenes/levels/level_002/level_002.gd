extends Node2D

@onready var player: PlayablePlayer = %Player
@onready var train: Train = %Train
@onready var machine_hs = %MachineHS
@onready var ticket_audio = %TicketAudio


var has_ticket: bool = false


func _ready():
	train.arrive()


func _on_train_arrived():
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/levels/level_002/level_002.dialogue"),
		"start"
	)


func appear():
	player.visible = true
	player.enable()


func buy_ticket():
	has_ticket = true
	ticket_audio.play(0.5)


func play_machine_hs():
	machine_hs.play()


func train_departure():
	train.leave()
	player.visible = false
	player.disable()


func finish():
		get_tree().change_scene_to_file("res://scenes/levels/finish.tscn")
