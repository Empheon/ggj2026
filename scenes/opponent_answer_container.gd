extends PanelContainer

@export var answer_label: Label
@export var liar_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func display_answer(answer: bool) -> void:
	if answer:
		answer_label.text = "YES"
	else:
		answer_label.text = "NO"

	# var tw := create_tween().set_ease(Tween.EASE_OUT)
	# tw.tween_property(answer_label, "position",, 0.3)
