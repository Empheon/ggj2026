extends Control

@export var play_button : BaseButton

func _ready() -> void:
	play_button.hide()
	await get_tree().create_timer(0.4).timeout
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.set_parallel()
	tween.tween_callback(play_button.show).set_delay(1)
	tween.tween_property(play_button,"scale",Vector2.ONE,0.6).from(Vector2.ONE*0.6).set_delay(1)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)\
		.tween_property(play_button,"self_modulate",Color.WHITE,1)\
		.from(Color(4,4,4,1)).set_delay(1)
	await tween.finished
	var loop_tween := create_tween().set_loops()
	loop_tween.tween_property(play_button,"self_modulate",Color(1.3,1.3,1.3,1),1)
	loop_tween.tween_property(play_button,"self_modulate",Color(1,1,1,1),1)
