extends Node2D


@onready var arriving_train: Train = %Arriving_Train
@onready var departure_train: Train = $Departure_Train
@onready var player: PlayablePlayer = %Player
@onready var ticket_audio = %TicketAudio


var has_ticket: bool = false


func _ready():
	arriving_train.arrive()


func _on_train_arrived():
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/levels/level_003/level_003.dialogue"),
		"start"
	)


func appear():
	player.visible = true
	player.enable()


func buy_ticket():
	has_ticket = true
	ticket_audio.play(0.5)


func train_departure():
	player.disable()
	player.visible = false
	departure_train.leave()


func finish():
	print("c'est le finish")
	get_tree().change_scene_to_file("res://scenes/finish.tscn")
