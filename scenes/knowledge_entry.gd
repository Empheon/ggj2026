class_name KnowledgeEntry
extends PanelContainer

@export var answer_icon: TextureRect
@export var emplacement_icon: TextureRect
@export var emplacement_name: Label
@export var value_icon: TextureRect
@export var value_name: Label

var question : Question
var answer : bool

func _ready() -> void:
	update()

func update():
	if not question or not is_inside_tree():
		return
	answer_icon.texture = preload("uid://c0wmk0pcd6t0p") if answer else preload("uid://df7v4td3d6gqq")
	emplacement_icon.texture = Config.ELEMENT_TYPE_ICON[question.emplacement]
	emplacement_name.text = Config.ELEMENT_TYPE_NAME[question.emplacement]
	match question.caracteristique:
		"couleur":
			value_icon.texture = Config.COLOR_ICON[question.value]
			value_name.text = Config.COLOR_NAME[question.value]
		"forme":
			value_icon.texture = Config.SHAPE_ICON[question.value]
			value_name.text = Config.SHAPE_NAME[question.value]
