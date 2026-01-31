class_name Config
extends RefCounted

const ELEMENT_TYPE_ICON : Dictionary[String, Texture2D] = {
	"any" : preload("uid://erktnwnvsbjj"),
	"face":preload("uid://cpofgtgt1oqo6"),
	"coiffe":preload("uid://demfsa3fkpqut"),
	"yeux":preload("uid://vwjywu6ra06e"),
	"nez":preload("uid://bndyfh8msxdu1"),
	"bouche":preload("uid://bwaikg2oxhk1y")
}

const ELEMENT_TYPE_NAME : Dictionary[String, String] = {
	"any":"Any",
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

const CARACTERISTIQUE_ICON : Dictionary[String, Texture2D] = {
	"couleur" : preload("uid://cgvgwg1ehm64e"),
	"forme" : preload("uid://cjyn5hywh62bl"),
	"matiere" : preload("uid://cfr4o7jn8m77e")
}

const MATIERE_TEXTURE : Dictionary[String, Texture2D] = {
	"plastic":preload("uid://c0ulah8ifd8wu"),
	"wood":preload("uid://be61um14tiwyu"),
	"metal":preload("uid://w8nbayy3wcq6"),
	"fur":preload("uid://bfoq1yn54d3on"),
	"rock":preload("uid://chtn4v3jx70rk")
}

const COULEUR_COLOR_CODE : Dictionary[String, Color] = {
	"red":Color(0.953, 0.227, 0.239, 1.0),
	"yellow":Color(1.0, 0.678, 0.278, 1.0),
	"green":Color(0.392, 0.678, 0.286, 1.0),
	"blue":Color(0.082, 0.537, 0.792, 1.0),
	"purple":Color(0.678, 0.267, 0.722, 1.0),
}
