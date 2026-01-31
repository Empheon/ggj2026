extends Control

@export var player_mask: Mask
@export var submit_button: Button
@export var color_popup: PanelContainer
@export var texture_pack_popup: PanelContainer

@export var color_value_buttons: Array[ButtonItemColor]
@export var texture_pack_value_buttons: Array[ButtonItemShape]

var solution_mask_info: MaskInfo
var current_element_type: String

func _ready() -> void:
	solution_mask_info = MaskInfo.new()
	color_popup.hide()
	texture_pack_popup.hide()
	connect_signals()
	update_solution()
	submit_button.disabled = true
	
func connect_signals():
	player_mask.element_clicked.connect(_on_mask_element_clicked)
	for color_value_button in color_value_buttons:
		color_value_button.pressed.connect(_on_color_value_button_pressed.bind(color_value_button))
	for shape_value_button in texture_pack_value_buttons:
		shape_value_button.pressed.connect(_on_shape_value_button_pressed.bind(shape_value_button))

	submit_button.pressed.connect(GameState.player_submit_solution.bind(solution_mask_info))
		
func _on_mask_element_clicked(_element: MaskElement, element_type: String):
	current_element_type = element_type
	show_texture_pack_popup()
	color_popup.show()

func show_texture_pack_popup():
	var all_texturepacks: Array[MaskElementTexturePack] = []
	match current_element_type:
		"face":
			all_texturepacks.assign(Library.all_faces_texturepacks)
		"coiffe":
			all_texturepacks.assign(Library.all_coiffes_texturepacks)
		"yeux":
			all_texturepacks.assign(Library.all_yeux_texturepacks)
		"bouche":
			all_texturepacks.assign(Library.all_bouches_texturepacks)
	for texture_pack in all_texturepacks:
		get_texture_pack_button_for(texture_pack.forme).icon = texture_pack.fill_texture
	texture_pack_popup.show()

func get_texture_pack_button_for(forme: String) -> ButtonItemShape:
	var candidates = texture_pack_value_buttons.filter(func(button: ButtonItemShape):
		return button.value == forme)
	if candidates.is_empty():
		return null
	return candidates.front()

func update_solution():
	player_mask.mask_info = solution_mask_info
	submit_button.disabled = not solution_mask_info.is_valid()

func _on_color_value_button_pressed(color_value_button: ButtonItemColor):
	match current_element_type:
		"face":
			solution_mask_info.face_info.couleur = color_value_button.value
		"coiffe":
			solution_mask_info.coiffe_info.couleur = color_value_button.value
		"yeux":
			solution_mask_info.yeux_info.couleur = color_value_button.value
		"bouche":
			solution_mask_info.bouche_info.couleur = color_value_button.value
	color_popup.hide()
	update_solution()

func _on_shape_value_button_pressed(shape_value_button: ButtonItemShape):
	match current_element_type:
		"face":
			solution_mask_info.face_info.forme = shape_value_button.value
			solution_mask_info.face_info.texture_pack = Library.get_texture_pack("face", shape_value_button.value)
		"coiffe":
			solution_mask_info.coiffe_info.forme = shape_value_button.value
			solution_mask_info.coiffe_info.texture_pack = Library.get_texture_pack("coiffe", shape_value_button.value)
		"yeux":
			solution_mask_info.yeux_info.forme = shape_value_button.value
			solution_mask_info.yeux_info.texture_pack = Library.get_texture_pack("yeux", shape_value_button.value)
		"bouche":
			solution_mask_info.bouche_info.forme = shape_value_button.value
			solution_mask_info.bouche_info.texture_pack = Library.get_texture_pack("bouche", shape_value_button.value)
	texture_pack_popup.hide()
	update_solution()
