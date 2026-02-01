extends BaseButton

func _ready() -> void:
	connect("pressed", _loadMainScene)

func _loadMainScene() -> void:
	self_modulate = Color.WEB_GRAY
	await get_tree().process_frame
	get_tree().change_scene_to_file('res://scenes/main_scene.tscn')
