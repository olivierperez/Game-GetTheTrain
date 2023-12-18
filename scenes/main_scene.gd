extends Node2D


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_001/level_001.tscn")
