class_name MaskInfo
extends Resource

@export var face_info : MaskElementInfo
@export var coiffe_info : MaskElementInfo
@export var yeux_info : MaskElementInfo
@export var bouche_info : MaskElementInfo

var all_elements : Array[MaskElementInfo]:
	get:
		return [face_info, coiffe_info, yeux_info, bouche_info]

func _init():
	face_info = MaskElementInfo.new()
	coiffe_info = MaskElementInfo.new()
	yeux_info = MaskElementInfo.new()
	bouche_info = MaskElementInfo.new()
