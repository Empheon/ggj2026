# Library (Autoload)
extends Node

@onready var all_bouches_texturepacks := preload("uid://dp3mx74myum0p").load_all()
@onready var all_coiffes_texturepacks := preload("uid://bq8ylbi5wnd4l").load_all()
@onready var all_faces_texturepacks := preload("uid://bpyse7iaueocx").load_all()
@onready var all_yeux_texturepacks := preload("uid://duspf72n51iu0").load_all()

func get_texture_pack(element:String, shape:String) -> MaskElementTexturePack:
	match element:
		"bouche":
			return all_bouches_texturepacks.filter(func(texture_pack:MaskElementTexturePack):
					return texture_pack.forme == shape).front()
		"coiffe":
			return all_coiffes_texturepacks.filter(func(texture_pack:MaskElementTexturePack):
					return texture_pack.forme == shape).front()
		"face":
			return all_faces_texturepacks.filter(func(texture_pack:MaskElementTexturePack):
					return texture_pack.forme == shape).front()
		"yeux":
			return all_yeux_texturepacks.filter(func(texture_pack:MaskElementTexturePack):
					return texture_pack.forme == shape).front()
	return null
