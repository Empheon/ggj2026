class_name MaskElement
extends TextureRect


signal hovered
signal hovered_out
signal clicked

var hover_tween : Tween

@export_enum("red", "yellow", "green", "blue", "purple") var couleur : String
@export_enum("square", "triangle", "round", "spiky", "polygon") var forme : String
@export_enum("plastic", "wood", "metal", "fur", "rock") var matiere : String


func _ready() -> void:
	material = preload("res://templates/mask_element_material.tres")
	set_instance_shader_parameter("width",0)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	z_index = 0

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		clicked.emit()
		print("%s clicked" % name)
		get_viewport().set_input_as_handled()

func set_outline_width(width:float):
	set_instance_shader_parameter(&"width", width)

func has_caracteristique_value(caracteristique:StringName, value:String) -> bool:
	match caracteristique:
		&"couleur":
			return couleur == value
		&"forme":
			return forme == value
		&"matiere":
			return matiere == value
	return false

func _on_mouse_entered():
	if hover_tween and hover_tween.is_running():
		hover_tween.kill()
	hover_tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	hover_tween.tween_method(set_outline_width, get_instance_shader_parameter("width"), 5.0, 0.6)
	z_index = 1
	hovered.emit()

func _on_mouse_exited():
	if hover_tween and hover_tween.is_running():
		hover_tween.kill()
	hover_tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	hover_tween.tween_method(set_outline_width, get_instance_shader_parameter("width"), 0.0, 0.3)
	z_index = 0
	hovered_out.emit()
