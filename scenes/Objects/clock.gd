extends Node2D
class_name Clock

signal timeout

@export var start_hours: int = 9
@export var start_minutes: int = 0
@export var end_hours: int = 99
@export var end_minutes: int = 99

var current_hours: int
var current_minutes: int
var current_seconds: int = 0

var show_colon = true
@onready var label: Label = $ColorRect/Label

func _ready():
	current_hours = start_hours
	current_minutes = start_minutes
	_update_time()


func _update_time():
	var colon = ":" if show_colon else " "
	var hours = str(current_hours) if current_hours >= 10 else "0" + str(current_hours)
	var minutes = str(current_minutes) if current_minutes >= 10 else "0" + str(current_minutes)
	label.text = hours + colon + minutes


func _on_tick():
	current_seconds += 1

	if current_seconds >= 60:
		current_seconds = 0
		current_minutes += 1

	if current_minutes >= 60:
		current_minutes = 0
		current_hours += 1

	if current_hours >= end_hours and current_minutes >= end_minutes:
		timeout.emit()

	show_colon = !show_colon
	_update_time()
