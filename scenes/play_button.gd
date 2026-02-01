extends BaseButton

func _ready() -> void:
	connect("pressed", _loadMainScene)

func _loadMainScene() -> void:
	get_tree().change_scene_to_file('res://scenes/main_scene.tscn')
