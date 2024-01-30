extends Node2D

@onready var click_audio = $ClickAudio
@onready var start_button = %StartButton


func _on_start_button_pressed():
	click_audio.play()
	await click_audio.finished
	get_tree().change_scene_to_file("res://scenes/levels/level_001/level_001.tscn")
