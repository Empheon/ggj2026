extends PanelContainer

signal deferred

@export var knowledge_items_container: VBoxContainer
@export var knowledge_entry_packedscene: PackedScene
@export var scroll_container: ScrollContainer

func _ready() -> void:
	GameState.player_knowledge_acquired.connect(_on_knowledge_acquired)
	for entry in knowledge_items_container.get_children():
		entry.queue_free()

func _on_knowledge_acquired(knowledge: Dictionary):
	var knowledge_entry: KnowledgeEntry = knowledge_entry_packedscene.instantiate()
	knowledge_entry.question = knowledge.keys().front()
	knowledge_entry.answer = knowledge.values().front()
	knowledge_items_container.add_child(knowledge_entry)

	await wait_deferred()
	scroll_container.set_deferred("scroll_vertical", 99999)

func wait_deferred() -> Signal:
	var deferred_signal := Signal(deferred)
	deferred_signal.emit.call_deferred()
	return deferred_signal
