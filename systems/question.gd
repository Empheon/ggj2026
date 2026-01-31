class_name Question
extends Resource

var emplacement : StringName = &"" # &"any", "face", "coiffe", "yeux", "bouche"
var caracteristique : StringName = &"" # &"couleur", "forme"
var value : String = "" # can be a lot of things

func is_valid() -> bool:
	return not emplacement.is_empty() and not caracteristique.is_empty() and not value.is_empty()
