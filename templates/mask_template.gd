class_name Mask
extends Control


signal element_hovered(element:MaskElement, element_type:String)
signal element_hovered_out()

@export var face : MaskElement
@export var coiffe : MaskElement
@export var yeux : MaskElement
@export var nez : MaskElement
@export var bouche : MaskElement

var mask_info : MaskInfo :
	set(value):
		mask_info = value
		setup()

var all_elements : Array[MaskElement] : 
	get:
		return [face, coiffe, yeux, nez, bouche]

func _ready() -> void:
	connect_signals()

func setup():
	assign_mask_elements_infos()

func assign_mask_elements_infos():
	face.mask_element_info = mask_info.face_info
	coiffe.mask_element_info = mask_info.coiffe_info
	yeux.mask_element_info = mask_info.yeux_info
	nez.mask_element_info = mask_info.nez_info
	bouche.mask_element_info = mask_info.bouche_info

func connect_signals():
	face.hovered.connect(element_hovered.emit.bind(face,"face"))
	coiffe.hovered.connect(element_hovered.emit.bind(coiffe,"coiffe"))
	yeux.hovered.connect(element_hovered.emit.bind(yeux,"yeux"))
	nez.hovered.connect(element_hovered.emit.bind(nez,"nez"))
	bouche.hovered.connect(element_hovered.emit.bind(bouche,"bouche"))
	face.hovered_out.connect(element_hovered_out.emit)
	coiffe.hovered_out.connect(element_hovered_out.emit)
	yeux.hovered_out.connect(element_hovered_out.emit)
	nez.hovered_out.connect(element_hovered_out.emit)
	bouche.hovered_out.connect(element_hovered_out.emit)
	

func is_equivalent_to(other_mask:Mask) -> bool:
	#var is_face_matching := face.texture == other_mask.face.texture
	#var is_coiffe_matching := coiffe.texture == other_mask.coiffe.texture
	#var is_yeux_matching := yeux.texture == other_mask.yeux.texture
	#var is_nez_matching := nez.texture == other_mask.nez.texture
	#var is_bouche_matching := bouche.texture == other_mask.bouche.texture
	#return is_face_matching and is_coiffe_matching and is_yeux_matching and is_nez_matching and is_bouche_matching
	return true
