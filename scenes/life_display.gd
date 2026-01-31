extends MarginContainer

@export var hearts : Array[TextureRect]
@export var heart_full : Texture2D
@export var heart_empty : Texture2D

func _ready() -> void:
	GameState.player_hp_changed.connect(update)
	update()

func update():
	for idx in range(hearts.size()):
		hearts[idx].texture = heart_full if idx < GameState.player_hp else heart_empty
