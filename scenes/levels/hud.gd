extends CanvasLayer
class_name HUD

signal on_action_clicked(code: String)

@export var player: PlayablePlayer

var _code1: String = ""
var _code2: String = ""

var messageLabel: Label
var action1Button: Button
var action2Button: Button

func _ready():
	$MessageNode.hide()
	messageLabel = $MessageNode/Shape/Message
	action1Button = $MessageNode/Shape/HFlowContainer/Action1Button
	action2Button = $MessageNode/Shape/HFlowContainer/Action2Button


func show_message(
	message: String,
	action1: String,
	code1: String = "",
	action2: String = "",
	code2: String = ""
):
	messageLabel.text = message
	action1Button.text = action1
	_code1 = code1
	if action2 != "":
		action2Button.text = action2
		action2Button.show()
		_code2 = code2
	else:
		action2Button.hide()
	$MessageNode.show()

	player.disable()


func hide_message():
	$MessageNode.hide()
	player.enable()


func _on_action_1_button_pressed():
	hide_message()
	on_action_clicked.emit(_code1)


func _on_action_2_button_pressed():
	hide_message()
	on_action_clicked.emit(_code2)
