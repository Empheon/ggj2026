extends Control

@export var try_again_button: Button
@export var reason_text: Label

func _ready() -> void:
	hide()
	try_again_button.pressed.connect(get_tree().reload_current_scene)
	GameState.gameover.connect(show_gameover)

func show_gameover(reason: String):
	match reason:
		&"no_hp":
			reason_text.text = "You guessed wrong!"
		&"lie":
			reason_text.text = "I know you lied!!!"
		&"enemy_guessed":
			reason_text.text = "I guessed my mask before you!"
	show()
