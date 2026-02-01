class_name Config
extends RefCounted

const ELEMENT_TYPE_ICON : Dictionary[String, Texture2D] = {
	"any" : preload("uid://erktnwnvsbjj"),
	"face":preload("uid://cpofgtgt1oqo6"),
	"coiffe":preload("uid://demfsa3fkpqut"),
	"yeux":preload("uid://vwjywu6ra06e"),
	"bouche":preload("uid://bwaikg2oxhk1y")
}

const ELEMENT_TYPE_NAME : Dictionary[String, String] = {
	"any":"Something",
	"face":"Base",
	"coiffe":"Hairstyle",
	"yeux":"Eyes",
	"bouche":"Mouth"
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


const CARACTERISTIQUE_ICON : Dictionary[String, Texture2D] = {
	"couleur" : preload("uid://cgvgwg1ehm64e"),
	"forme" : preload("uid://cjyn5hywh62bl"),
}


const COULEUR_COLOR_CODE : Dictionary[String, Color] = {
	"red":Color(0.953, 0.227, 0.239, 1.0),
	"yellow":Color(1.0, 0.678, 0.278, 1.0),
	"green":Color(0.392, 0.678, 0.286, 1.0),
	"blue":Color(0.082, 0.537, 0.792, 1.0),
	"purple":Color(0.678, 0.267, 0.722, 1.0),
}
