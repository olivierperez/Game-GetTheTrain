extends CanvasLayer
class_name HUD

signal on_action_clicked(code: String)

@export var player: PlayablePlayer

var _code1: String = ""
var _code2: String = ""

@onready var messageLabel: Label = $MessageNode/Shape/Message
@onready var action1Button = %Action1Button
@onready var action2Button = %Action2Button

func _ready():
	$MessageNode.hide()


func hide_message():
	$MessageNode.hide()
	player.enable()


func _on_action_1_button_pressed():
	$ClickAudio.play()
	hide_message()
	on_action_clicked.emit(_code1)


func _on_action_2_button_pressed():
	$ClickAudio.play()
	hide_message()
	on_action_clicked.emit(_code2)
