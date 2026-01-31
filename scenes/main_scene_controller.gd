extends Node

@export var ask_question_ui : Control
@export var ask_question_container : Control
@export var emplacement_popup : Control
@export var caracteristique_popup : Control
@export var color_popup : Control
@export var forme_popup : Control
@export var matiere_popup : Control

@export var question_emplacement_button : Button
@export var question_caracteristique_button : Button
@export var question_value_button : Button

@export var emplacement_value_buttons : Array[ButtonItemEmplacement]
@export var caracteristique_value_buttons : Array[ButtonItemCaracteristique]

var current_question : Question

func _ready() -> void:
	current_question = Question.new()
	hide_popups()
	connect_signals()
	question_value_button.disabled = true

func hide_popups():
	emplacement_popup.hide()
	caracteristique_popup.hide()
	color_popup.hide()
	forme_popup.hide()
	matiere_popup.hide()

func connect_signals():
	question_emplacement_button.pressed.connect(_on_question_emplacement_button_pressed)
	question_caracteristique_button.pressed.connect(_on_question_caracteristique_button_pressed)
	question_value_button.pressed.connect(_on_question_value_button_pressed)
	for emplacement_value_button in emplacement_value_buttons:
		emplacement_value_button.pressed.connect(_on_question_button_pressed.bind(emplacement_value_button, question_emplacement_button))
	for caracteristique_value_button in caracteristique_value_buttons:
		caracteristique_value_button.pressed.connect(_on_question_button_pressed.bind(caracteristique_value_button, question_caracteristique_button))

func _on_question_button_pressed(origin_button:Button, destination_button:Button):
	destination_button.icon = origin_button.icon
	if origin_button is ButtonItemEmplacement:
		current_question.emplacement = origin_button.value
	elif origin_button is ButtonItemCaracteristique:
		current_question.caracteristique = origin_button.value
	hide_popups()


func _on_question_emplacement_button_pressed():
	hide_popups()
	emplacement_popup.show()

func _on_question_caracteristique_button_pressed():
	hide_popups()
	caracteristique_popup.show()

func _on_question_value_button_pressed():
	hide_popups()
	if current_question.caracteristique.is_empty():
		print("error : impossible d'ouvrir le selecteur de valeur car aucune caracteristique n'est renseignée dans la question")
		# this should not happen
		return
	match current_question.caracteristique:
		&"couleur":
			color_popup.show()
		&"forme":
			forme_popup.show()
		&"matiere":
			matiere_popup.show()
