extends Control

@export var continue_button : Button

func _ready() -> void:
	hide()
	continue_button.pressed.connect(get_tree().reload_current_scene)
	GameState.victory.connect(show_victory)

func show_victory():
	show()
