class_name MaskElementInfo
extends Resource

@export var texture_pack : MaskElementTexturePack
var forme : String
var couleur : String

func has_caracteristique_value(caracteristique:StringName, value:String) -> bool:
	match caracteristique:
		&"couleur":
			return couleur == value
		&"forme":
			return forme == value
	return false
