class_name Mask
extends Control

const PLAIN_MASK : MaskInfo = preload("uid://3n81kwgojaj6")

signal element_hovered(element:MaskElement, element_type:String)
signal element_hovered_out()
signal element_clicked(element:MaskElement, element_type:String)

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
	face.mask_element_info = mask_info.face_info if mask_info.face_info.texture_pack else PLAIN_MASK.face_info
	coiffe.mask_element_info = mask_info.coiffe_info if mask_info.coiffe_info.texture_pack else PLAIN_MASK.coiffe_info
	yeux.mask_element_info = mask_info.yeux_info if mask_info.yeux_info.texture_pack else PLAIN_MASK.yeux_info
	bouche.mask_element_info = mask_info.bouche_info if mask_info.bouche_info.texture_pack else PLAIN_MASK.bouche_info

func connect_signals():
	face.hovered.connect(element_hovered.emit.bind(face,"face"))
	coiffe.hovered.connect(element_hovered.emit.bind(coiffe,"coiffe"))
	yeux.hovered.connect(element_hovered.emit.bind(yeux,"yeux"))
	bouche.hovered.connect(element_hovered.emit.bind(bouche,"bouche"))
	face.clicked.connect(element_clicked.emit.bind(face,"face"))
	coiffe.clicked.connect(element_clicked.emit.bind(coiffe,"coiffe"))
	yeux.clicked.connect(element_clicked.emit.bind(yeux,"yeux"))
	bouche.clicked.connect(element_clicked.emit.bind(bouche,"bouche"))
	face.hovered_out.connect(element_hovered_out.emit)
	coiffe.hovered_out.connect(element_hovered_out.emit)
	yeux.hovered_out.connect(element_hovered_out.emit)
	bouche.hovered_out.connect(element_hovered_out.emit)
