extends Button

@export var popup: Control
@export var items_grid: GridContainer

func _ready() -> void:
	pressed.connect(_toggle_popup)

	# Bind all existing item buttons in the grid
	for child in items_grid.get_children():
		if child is Button:
			(child as Button).pressed.connect(_on_item_pressed.bind(child))

	popup.visible = false

func _toggle_popup() -> void:
	AudioManager.play_click()
	popup.visible = !popup.visible

func _on_item_pressed(item_button: Button) -> void:
	icon = item_button.icon

	popup.visible = false
