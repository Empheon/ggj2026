extends Control

@export var resume_button: Button
@export var quit_button: Button
@export var canvas_layer: CanvasLayer

func _ready() -> void:
	canvas_layer.hide()
	connect_signals()
	pass

func connect_signals() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _input(event):
	if event.is_action_pressed("pause"):
		if canvas_layer.is_visible():
			canvas_layer.hide()
		else:
			canvas_layer.show()

func _on_resume_button_pressed() -> void:
	canvas_layer.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
