class_name MaskElement
extends TextureButton

signal hovered
signal hovered_out
signal clicked

var hover_tween : Tween

var mask_element_info : MaskElementInfo :
	set(value):
		mask_element_info = value
		setup()

var line_texturerect : TextureRect : 
	get:
		return get_node("../%sLine" % name)

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func setup():
	if not is_inside_tree() or not mask_element_info:
		return
	setup_textures()
	create_auto_click_mask()

func setup_textures():
	texture_normal = mask_element_info.texture_pack.fill_texture
	texture_hover = mask_element_info.texture_pack.fill_texture
	texture_focused = mask_element_info.texture_pack.fill_texture
	line_texturerect.texture = mask_element_info.texture_pack.line_texture
	self_modulate = Config.COULEUR_COLOR_CODE[mask_element_info.couleur] if not mask_element_info.couleur.is_empty() else Color.WHITE

func create_auto_click_mask():
	texture_click_mask = BitMap.new()
	var normal_image := texture_normal.get_image()
	if normal_image.is_compressed():
		normal_image.decompress()
	texture_click_mask.create_from_image_alpha(normal_image)

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		clicked.emit()
		get_viewport().set_input_as_handled()

func _on_mouse_entered():
	if hover_tween and hover_tween.is_running():
		hover_tween.kill()
	hover_tween = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	hover_tween.tween_property(line_texturerect,"self_modulate",Color.YELLOW,0.3)
	hovered.emit()

func _on_mouse_exited():
	if hover_tween and hover_tween.is_running():
		hover_tween.kill()
	hover_tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	hover_tween.tween_property(line_texturerect,"self_modulate",Color.BLACK,0.3)
	hovered_out.emit()
