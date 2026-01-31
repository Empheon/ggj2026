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
