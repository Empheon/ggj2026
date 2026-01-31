class_name MaskElementTooltip
extends PanelContainer

@export var element_type_icon : TextureRect
@export var element_type_label : Label

@export var couleur_value_icon: TextureRect
@export var couleur_value_name: Label
@export var forme_value_icon: TextureRect
@export var forme_value_name: Label
@export var matiere_value_icon: TextureRect
@export var matiere_value_name: Label

func _ready() -> void:
	hide()

func show_for(mask_element:MaskElement, element_type:String):
	element_type_icon.texture = Config.ELEMENT_TYPE_ICON[element_type]
	element_type_label.text = Config.ELEMENT_TYPE_NAME[element_type]
	couleur_value_icon.texture = Config.COLOR_ICON[mask_element.couleur]
	couleur_value_name.text = Config.COLOR_NAME[mask_element.couleur]
	forme_value_icon.texture = Config.SHAPE_ICON[mask_element.forme]
	forme_value_name.text = Config.SHAPE_NAME[mask_element.forme]
	matiere_value_icon.texture = Config.MATIERE_ICON[mask_element.matiere]
	matiere_value_name.text = Config.MATIERE_NAME[mask_element.matiere]
	show()
	global_position = mask_element.global_position + mask_element.size/2 + Vector2(250,10)
