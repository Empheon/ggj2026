class_name Mask
extends Control


@export var face : MaskElement
@export var coiffe : MaskElement
@export var yeux : MaskElement
@export var nez : MaskElement
@export var bouche : MaskElement

var all_elements : Array[MaskElement] : 
	get:
		return [face, coiffe, yeux, nez, bouche]

func is_equivalent_to(other_mask:Mask) -> bool:
	var is_face_matching := face.texture == other_mask.face.texture
	var is_coiffe_matching := coiffe.texture == other_mask.coiffe.texture
	var is_yeux_matching := yeux.texture == other_mask.yeux.texture
	var is_nez_matching := nez.texture == other_mask.nez.texture
	var is_bouche_matching := bouche.texture == other_mask.bouche.texture
	return is_face_matching and is_coiffe_matching and is_yeux_matching and is_nez_matching and is_bouche_matching
