extends Control

@export var title_1 : Label
@export var title_2 : Label
@export var play_button : Button

func _ready() -> void:
	title_1.self_modulate.a = 0.0
	title_2.self_modulate.a = 0.0
	play_button.hide()
	await get_tree().create_timer(0.4).timeout
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.set_parallel()
	tween.tween_property(title_1,"scale",Vector2.ONE,1.5).from(Vector2.ONE*0.2)
	tween.tween_property(title_1,"self_modulate:a",1.0,0.4)
	tween.tween_property(title_2,"scale",Vector2.ONE,1.5).from(Vector2.ONE*0.2).set_delay(0.5)
	tween.tween_property(title_2,"self_modulate:a",1.0,0.4).set_delay(0.5)
	tween.tween_callback(play_button.show).set_delay(1)
	tween.tween_property(play_button,"scale",Vector2.ONE,0.6).from(Vector2.ONE*0.6).set_delay(1)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)\
		.tween_property(play_button,"self_modulate",Color.WHITE,1)\
		.from(Color(4,4,4,1)).set_delay(1)
	await tween.finished
	var loop_tween := create_tween().set_loops()
	loop_tween.tween_property(play_button,"self_modulate",Color(2,2,2,1),1)
	loop_tween.tween_property(play_button,"self_modulate",Color(1,1,1,1),1)
