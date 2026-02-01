class_name YesNoPanelContainer
extends PanelContainer

signal player_answered(answer:bool)

@export var yes_button : Button
@export var no_button : Button

@export var yes_is_lying_label : Label
@export var no_is_lying_label : Label

func _ready() -> void:
	yes_button.pressed.connect(_on_yes_button_pressed)
	no_button.pressed.connect(_on_no_button_pressed)

func show_for_question(question:Question):
	var truth := GameState.get_mask_truth(GameState.enemy_mask, question)
	yes_is_lying_label.text = "(Lie)" if not truth else ""
	no_is_lying_label.text = "(Lie)" if truth else ""
	show()
	modulate.a = 0.0
	scale = Vector2.ONE*0.2
	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.set_parallel()
	tween.tween_property(self,"scale",Vector2.ONE,0.5)
	tween.set_trans(Tween.TRANS_QUART).tween_property(self,"modulate:a",1.0,0.4)

func _on_yes_button_pressed():
	AudioManager.play_say_yes()
	player_answered.emit(true)

func _on_no_button_pressed():
	AudioManager.play_say_no()
	player_answered.emit(false)
