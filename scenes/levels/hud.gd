extends CanvasLayer
class_name HUD

signal on_action_clicked(code: String)

var _code1: String = ""
var _code2: String = ""


func _ready():
	$MessageNode.hide()


func show_message(
	message: String,
	action1: String,
	code1: String = "",
	action2: String = "",
	code2: String = ""
):
	$MessageNode/Message.text = message
	$MessageNode/HFlowContainer/Action1Button.text = action1
	_code1 = code1
	if action2 != "":
		$MessageNode/HFlowContainer/Action2Button.text = action2
		$MessageNode/HFlowContainer/Action2Button.show()
		_code2 = code2
	else:
		$MessageNode/HFlowContainer/Action2Button.hide()
	$MessageNode.show()


func hide_message():
	$MessageNode.hide()


func _on_action_1_button_pressed():
	$MessageNode.hide()
	on_action_clicked.emit(_code1)


func _on_action_2_button_pressed():
	$MessageNode.hide()
	on_action_clicked.emit(_code2)
