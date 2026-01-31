extends PanelContainer

# "face", "coiffe", "yeux", "nez", "bouche"

const ELEMENT_TYPE_ICON : Dictionary[String, Texture2D] = {
	"face":preload("uid://cpofgtgt1oqo6"),
	"coiffe":preload("uid://demfsa3fkpqut"),
	"yeux":preload("uid://vwjywu6ra06e"),
	"nez":preload("uid://bndyfh8msxdu1"),
	"bouche":preload("uid://bwaikg2oxhk1y")
}

const ELEMENT_TYPE_NAME : Dictionary[String, String] = {
	"face":"Base",
	"coiffe":"Hairstyle",
	"yeux":"Eyes",
	"nez":"Nose",
	"bouche":"Mouth"
}

const COLOR_ICON : Dictionary[String, Texture2D] = {
	"red":preload("uid://dhfx8ojeuils"),
	"yellow":preload("uid://lajyp8f8liff"),
	"green":preload("uid://i2r4dny7psur"),
	"blue":preload("uid://e3f46cdssqkx"),
	"purple":preload("uid://bycvflinttavg"),
}

const COLOR_NAME : Dictionary[String, String] = {
	"red":"Red",
	"yellow":"Yellow",
	"green":"Green",
	"blue":"Blue",
	"purple":"Purple",
}

const SHAPE_ICON : Dictionary[String, Texture2D] = {
	"square":preload("uid://h5pduf4iqojv"),
	"triangle":preload("uid://cxaa54lidrht2"),
	"round":preload("uid://bbd8e4q87sin7"),
	"spiky":preload("uid://bbvih1002gv3a"),
	"polygon":preload("uid://lp2ex3syjqaw"),
}

const SHAPE_NAME : Dictionary[String, String] = {
	"square":"Square",
	"triangle":"Triangle",
	"round":"Round",
	"spiky":"Spiky",
	"polygon":"Angled",
}

const MATIERE_ICON : Dictionary[String, Texture2D] = {
	"plastic":preload("uid://bvqjb8b3u66y"),
	"wood":preload("uid://cr05qdjjehkw4"),
	"metal":preload("uid://cgxvhmt58r3xb"),
	"fur":preload("uid://dvxoyjaalklkb"),
	"rock":preload("uid://cuty8s7fjdc47")
}

const MATIERE_NAME : Dictionary[String, String] = {
	"plastic":"Plastic",
	"wood":"Wood",
	"metal":"Metal",
	"fur":"Fur",
	"rock":"Stone"
}

@export var element_type_icon : TextureRect
@export var element_type_label : Label

@export var couleur_value_icon: TextureRect
@export var couleur_value_name: Label
@export var forme_value_icon: TextureRect
@export var forme_value_name: Label
@export var matiere_value_icon: TextureRect
@export var matiere_value_name: Label

func show_for(mask_element:MaskElement, element_type:String):
	element_type_icon.texture = ELEMENT_TYPE_ICON[element_type]
	element_type_label.text = ELEMENT_TYPE_NAME[element_type]
	couleur_value_icon.texture = COLOR_ICON[mask_element.couleur]
	couleur_value_name.text = COLOR_NAME[mask_element.couleur]
	forme_value_icon.texture = SHAPE_ICON[mask_element.forme]
	forme_value_name.text = SHAPE_NAME[mask_element.forme]
	matiere_value_icon.texture = MATIERE_ICON[mask_element.matiere]
	matiere_value_name.text = MATIERE_NAME[mask_element.matiere]
	show()
	global_position = mask_element.global_position
