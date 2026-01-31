extends Node

@export var ask_question_ui: Control
@export var ask_question_container: Control
@export var emplacement_popup: Control
@export var caracteristique_popup: Control
@export var color_popup: Control
@export var forme_popup: Control
@export var matiere_popup: Control

@export var enemy_answer_popup : Control


@export var question_emplacement_button: Button
@export var question_caracteristique_button: Button
@export var question_value_button: Button

@export var emplacement_value_buttons: Array[ButtonItemEmplacement]
@export var caracteristique_value_buttons: Array[ButtonItemCaracteristique]
@export var color_value_buttons: Array[ButtonItemColor]
@export var shape_value_buttons: Array[ButtonItemShape]
@export var material_value_buttons: Array[ButtonItemMaterial]

@export var enemy_mask_container : Control

@export var enemy_question_container : OpponentQuestionContainer

@export var mask_element_tooltip : MaskElementTooltip

var current_question: Question

func _ready() -> void:
	current_question = Question.new()
	hide_popups()
	connect_signals()
	question_value_button.disabled = true
	GameState.start_round()
	enemy_mask_container.add_child(GameState.enemy_mask)
	GameState.enemy_mask.element_hovered.connect(_on_mask_element_hovered)
	GameState.enemy_mask.element_hovered_out.connect(_on_mask_element_hovered_out)
	show_enemy_question()

func hide_popups():
	emplacement_popup.hide()
	caracteristique_popup.hide()
	color_popup.hide()
	forme_popup.hide()
	matiere_popup.hide()

func untoggle_buttons(except_button: Button):
	for button in [question_emplacement_button, question_caracteristique_button, question_value_button]:
		if button != except_button:
			button.button_pressed = false

func connect_signals():
	question_emplacement_button.toggled.connect(_on_question_emplacement_button_toggled)
	question_caracteristique_button.toggled.connect(_on_question_caracteristique_button_toggled)
	question_value_button.toggled.connect(_on_question_value_button_toggled)

	for emplacement_value_button in emplacement_value_buttons:
		emplacement_value_button.pressed.connect(_on_question_button_pressed.bind(emplacement_value_button, question_emplacement_button))
	for caracteristique_value_button in caracteristique_value_buttons:
		caracteristique_value_button.pressed.connect(_on_question_button_pressed.bind(caracteristique_value_button, question_caracteristique_button))
		
	for color_value_button in color_value_buttons:
		color_value_button.pressed.connect(_on_question_button_pressed.bind(color_value_button, question_value_button))
	for shape_value_button in shape_value_buttons:
		shape_value_button.pressed.connect(_on_question_button_pressed.bind(shape_value_button, question_value_button))
	for material_value_button in material_value_buttons:
		material_value_button.pressed.connect(_on_question_button_pressed.bind(material_value_button, question_value_button))
	

func show_enemy_question():
	enemy_question_container.show_for_question(GameState.generate_enemy_question())


func _on_question_button_pressed(origin_button: Button, destination_button: Button):
	destination_button.icon = origin_button.icon
	if origin_button is ButtonItemEmplacement:
		current_question.emplacement = origin_button.value
	elif origin_button is ButtonItemCaracteristique:
		if current_question.caracteristique != origin_button.value:
			question_value_button.icon = null
			current_question.value = -1
		current_question.caracteristique = origin_button.value
		question_value_button.disabled = false
	elif origin_button is ButtonItemColor:
		current_question.value = origin_button.value
	elif origin_button is ButtonItemShape:
		current_question.value = origin_button.value
	elif origin_button is ButtonItemMaterial:
		current_question.value = origin_button.value
	hide_popups()
	untoggle_buttons(null)


func _on_question_emplacement_button_toggled(toggled: bool):
	if toggled:
		emplacement_popup.show()
		untoggle_buttons(question_emplacement_button)
	else:
		emplacement_popup.hide()

func _on_question_caracteristique_button_toggled(toggled: bool):
	if toggled:
		caracteristique_popup.show()
		untoggle_buttons(question_caracteristique_button)
	else:
		caracteristique_popup.hide()

func _on_question_value_button_toggled(toggled: bool):
	if toggled:
		untoggle_buttons(question_value_button)

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
	else:
		color_popup.hide()
		forme_popup.hide()
		matiere_popup.hide()

func _on_mask_element_hovered(element:MaskElement, element_type:String):
	mask_element_tooltip.show_for(element,element_type)

func _on_mask_element_hovered_out():
	mask_element_tooltip.hide()
