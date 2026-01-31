class_name YesNoPanelContainer
extends PanelContainer

signal player_answered(answer:bool)

@export var yes_button : Button
@export var no_button : Button

@export var yes_is_lying_label : Label
@export var no_is_lying_label : Label

func _ready() -> void:
	yes_button.pressed.connect(player_answered.emit.bind(true))
	no_button.pressed.connect(player_answered.emit.bind(false))

func show_for_question(question:Question):
	var truth := GameState.get_mask_truth(GameState.enemy_mask, question)
	yes_is_lying_label.text = "(Lie)" if not truth else ""
	no_is_lying_label.text = "(Lie)" if truth else ""
	show()
	
