class_name MaskInfo
extends Resource

@export var face_info : MaskElementInfo
@export var coiffe_info : MaskElementInfo
@export var yeux_info : MaskElementInfo
@export var nez_info : MaskElementInfo
@export var bouche_info : MaskElementInfo

var all_elements : Array[MaskElementInfo]:
	get:
		return [face_info, coiffe_info, yeux_info, nez_info, bouche_info]
