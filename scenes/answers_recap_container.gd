extends PanelContainer

@export var knowledge_items_container : VBoxContainer
@export var knowledge_entry_packedscene : PackedScene

func _ready() -> void:
	GameState.player_knowledge_acquired.connect(_on_knowledge_acquired)
	for entry in knowledge_items_container.get_children():
		entry.queue_free()

func _on_knowledge_acquired(knowledge:Dictionary):
	var knowledge_entry : KnowledgeEntry = knowledge_entry_packedscene.instantiate()
	knowledge_entry.question = knowledge.keys().front()
	knowledge_entry.answer = knowledge.values().front()
	knowledge_items_container.add_child(knowledge_entry)
