class_name OpponentQuestionContainer
extends PanelContainer

@export var emplacement_texture : TextureRect
@export var caracteristique_texture : TextureRect
@export var value_texture : TextureRect

func show_for_question(question:Question):
	emplacement_texture.texture = Config.ELEMENT_TYPE_ICON[question.emplacement]
	caracteristique_texture.texture = Config.CARACTERISTIQUE_ICON[question.caracteristique]
	value_texture.self_modulate = Color.WHITE
	match question.caracteristique:
		"couleur":
			value_texture.texture = preload("uid://dx7c6mpd1dpjs")
			value_texture.self_modulate = Config.COULEUR_COLOR_CODE[question.value]
		"forme":
			value_texture.texture = Config.SHAPE_ICON[question.value]
	show()
	modulate.a = 0.0
	scale = Vector2.ONE*0.2
	var tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.set_parallel()
	tween.tween_property(self,"scale",Vector2.ONE,0.5)
	tween.set_trans(Tween.TRANS_QUART).tween_property(self,"modulate:a",1.0,0.4)
	
