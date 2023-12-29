extends Node2D

@onready var hud: HUD = $HUD
@onready var leftDoorToDock: AutomaticDoor = $AutomaticDoor_toDock_left
@onready var rightDoorToDock: AutomaticDoor = $AutomaticDoor_toDock_right


var has_ticket: bool = false


func _ready():
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/levels/level_001/level_001.dialogue"),
		"start"
	)


func buy_ticket():
	has_ticket = true
	leftDoorToDock.unlock()
	rightDoorToDock.unlock()
	$TicketAudio.play(0.5)


func train_departure():
	$Train.leave()
	$Player.visible = false
	$Player.disable()


func finish():
	get_tree().change_scene_to_file("res://scenes/levels/level_002/level_002.tscn")


func _on_player_enter_in_doors_to_dock():
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/levels/level_001/level_001.dialogue"),
		"doors_to_dock"
	)


func _on_clock_timeout():
	$Player.disable()
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/levels/level_001/level_001.dialogue"),
		"timeout"
	)
