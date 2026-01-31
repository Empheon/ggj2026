class_name MaskElementInfo
extends Resource

@export var texture_pack : MaskElementTexturePack
@export var forme : String
@export var matiere : String
@export var couleur : String

func has_caracteristique_value(caracteristique:StringName, value:String) -> bool:
	match caracteristique:
		&"couleur":
			return couleur == value
		&"forme":
			return forme == value
		&"matiere":
			return matiere == value
	return false
