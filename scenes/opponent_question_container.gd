class_name OpponentQuestionContainer
extends PanelContainer

@export var emplacement_texture : TextureRect
@export var caracteristique_texture : TextureRect
@export var value_texture : TextureRect

func show_for_question(question:Question):
	emplacement_texture.texture = Config.ELEMENT_TYPE_ICON[question.emplacement]
	caracteristique_texture.texture = Config.CARACTERISTIQUE_ICON[question.caracteristique]
	match question.caracteristique:
		"couleur":
			value_texture.texture = Config.COLOR_ICON[question.value]
		"forme":
			value_texture.texture = Config.SHAPE_ICON[question.value]
	show()
