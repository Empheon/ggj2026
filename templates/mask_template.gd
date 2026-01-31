class_name Mask
extends Control


signal element_hovered(element:MaskElement, element_type:String)
signal element_hovered_out()

@export var face : MaskElement
@export var coiffe : MaskElement
@export var yeux : MaskElement
@export var bouche : MaskElement

var mask_info : MaskInfo :
	set(value):
		mask_info = value
		setup()

var all_elements : Array[MaskElement] : 
	get:
		return [face, coiffe, yeux, bouche]

func _ready() -> void:
	connect_signals()

func setup():
	assign_mask_elements_infos()

func assign_mask_elements_infos():
	face.mask_element_info = mask_info.face_info
	coiffe.mask_element_info = mask_info.coiffe_info
	yeux.mask_element_info = mask_info.yeux_info
	bouche.mask_element_info = mask_info.bouche_info

func connect_signals():
	face.hovered.connect(element_hovered.emit.bind(face,"face"))
	coiffe.hovered.connect(element_hovered.emit.bind(coiffe,"coiffe"))
	yeux.hovered.connect(element_hovered.emit.bind(yeux,"yeux"))
	bouche.hovered.connect(element_hovered.emit.bind(bouche,"bouche"))
	face.hovered_out.connect(element_hovered_out.emit)
	coiffe.hovered_out.connect(element_hovered_out.emit)
	yeux.hovered_out.connect(element_hovered_out.emit)
	bouche.hovered_out.connect(element_hovered_out.emit)
