extends Node2D


var has_ticket: bool = false


func _ready():
	pass


func _on_ticket_machine_entered():
	if !has_ticket:
		$HUD.show_message(
			"Je suis un distributeur de tickets de train.\nQuel ticket souhaites-tu acheter ?",
			"Ticket vers chez moi",
			"buy_ticket",
			"Partir en vacances",
			"go_holidays"
		)
	else:
		$HUD.show_message(
			"Tu as déjà un ticket, qu'est-ce que tu irais faire avec un second ?",
			"Ho... désolé"
		)


func _on_ticket_machine_exit():
	$HUD.hide_message()


func _on_hud_action_clicked(code):
	if code == "buy_ticket":
		has_ticket = true
		$AutomaticDoor_toDock_left.unlock()
		$AutomaticDoor_toDock_right.unlock()
	elif code == "go_holidays":
		$HUD.show_message(
			"Pauvre fou ! Il n'est pas l'heure de repartir en vacances.\nRentre donc chez toi, ta petite vie t'attend.",
			"Ok, je me ressaisi"
		)


func _on_player_enter_in_doors_to_dock():
	if !has_ticket:
		$HUD.show_message(
			"Ne compte pas prendre un train sans ticket mon ami.",
			"Ah oui, pas con"
		)
