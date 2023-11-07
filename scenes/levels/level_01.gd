extends Node2D


var has_ticket: bool = false
@onready var hud: HUD = $HUD
@onready var leftDoorToDock: AutomaticDoor = $AutomaticDoor_toDock_left
@onready var rightDoorToDock: AutomaticDoor = $AutomaticDoor_toDock_right

func _ready():
	hud.show_message(
		"Les vacances se sont bien passées ? Et bien elles sont finies !\nPrends le train de 10h pour rentrer chez toi.",
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


func _on_ticket_machine_exit():
	hud.hide_message()


func _on_hud_action_clicked(code):
	if code == "buy_ticket":
		has_ticket = true
		leftDoorToDock.unlock()
		rightDoorToDock.unlock()
		$TicketAudio.play(0.5)
	elif code == "go_holidays":
		hud.show_message(
			"Pauvre fou ! Il n'est pas l'heure de repartir en vacances.\nRentre donc chez toi, ta petite vie t'attend.",
			"Ok, je me ressaisi"
		)
	elif code == "finish":
		get_tree().change_scene_to_file("res://scenes/levels/finish.tscn")


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


func _on_train_locomotive_entered():
	hud.show_message(
		"Tu croyais vraiment que t'allais conduire !?",
		"Haha non c'était pour rire"
	)


func _on_train_wagons_entered():
	hud.show_message(
		"GG gros, t'as réussi à prendre ton train, vivement qu'on soit arrivés. J'espère qu'on n'aura pas de soucis en route...",
		"C'est parti",
		"finish"
	)
	$Train.leave()
	$Player.visible = false
	$Player.disable()
