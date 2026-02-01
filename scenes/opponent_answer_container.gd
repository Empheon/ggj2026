extends PanelContainer

@export var answer_label: Label
@export var liar_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func display_answer(answer: bool) -> void:
	if answer:
		answer_label.text = "YES"
	else:
		answer_label.text = "NO"
	show()
	modulate.a = 0.0
	scale = Vector2.ONE*0.2
	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.set_parallel()
	tween.tween_property(self,"scale",Vector2.ONE,0.5)
	tween.set_trans(Tween.TRANS_QUART).tween_property(self,"modulate:a",1.0,0.4)
