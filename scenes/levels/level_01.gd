extends Node2D


var has_ticket: bool = false
@onready var hud: HUD = $HUD
@onready var leftDoorToDock: AutomaticDoor = $AutomaticDoor_toDock_left
@onready var rightDoorToDock: AutomaticDoor = $AutomaticDoor_toDock_right

func _ready():
	hud.show_message(
		"Les vacances se sont bien passées ? Et bien elle sont finies !\nPrends le train de 10h pour rentrer chez toi.",
		"Message reçu"
	)


func _on_ticket_machine_entered():
	if !has_ticket:
		hud.show_message(
			"Je suis un distributeur de tickets de train.\nQuel ticket souhaites-tu acheter ?",
			"Ticket vers chez moi",
			"buy_ticket",
			"Partir en vacances",
			"go_holidays"
		)
	else:
		hud.show_message(
			"Tu as déjà un ticket, qu'est-ce que tu irais faire avec un second ?",
			"Ho... désolé"
		)


func _on_player_enter_hs_ticket_machine():
	if !has_ticket:
		hud.show_message(
			"Cette machine semble hors service, c'est étonnant.",
			"Arf!"
		)
	else:
		hud.show_message(
			"Tu as déjà un ticket, qu'est-ce que tu irais faire avec un second ?",
			"Ho... désolé"
		)


func _on_ticket_machine_exit():
	hud.hide_message()


func _on_hud_action_clicked(code):
	if code == "buy_ticket":
		has_ticket = true
		leftDoorToDock.unlock()
		rightDoorToDock.unlock()
	elif code == "go_holidays":
		hud.show_message(
			"Pauvre fou ! Il n'est pas l'heure de repartir en vacances.\nRentre donc chez toi, ta petite vie t'attend.",
			"Ok, je me ressaisi"
		)


func _on_player_enter_in_doors_to_dock():
	if !has_ticket:
		hud.show_message(
			"Ne compte pas prendre un train sans ticket mon ami.",
			"Ah oui, pas con"
		)


func _on_clock_timeout():
	$Player.disable()
	hud.show_message(
		"Trop tard, tu as raté ton train !",
		"Arf!"
	)
