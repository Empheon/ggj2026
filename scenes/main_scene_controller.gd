extends Node

@export var ask_question_ui: Control
@export var ask_question_container: Control
@export var ask_button: Button
@export var emplacement_popup: Control
@export var caracteristique_popup: Control
@export var color_popup: Control
@export var forme_popup: Control

@export var enemy_answer_popup: Control


@export var question_emplacement_button: Button
@export var question_caracteristique_button: Button
@export var question_value_button: Button

@export var emplacement_value_buttons: Array[ButtonItemEmplacement]
@export var caracteristique_value_buttons: Array[ButtonItemCaracteristique]
@export var color_value_buttons: Array[ButtonItemColor]
@export var shape_value_buttons: Array[ButtonItemShape]

@export var enemy_question_container: OpponentQuestionContainer
@export var yes_no_container: YesNoPanelContainer
@export var enemy_answer_container: PanelContainer

@export var mask_element_tooltip: MaskElementTooltip

@export var enemy_mask_view: Mask

@export var chara_blink_animation_player : AnimationPlayer

var current_player_question: Question

func _ready() -> void:
	current_player_question = Question.new()
	hide_popups()
	connect_signals()
	question_value_button.disabled = true
	GameState.start_round()
	enemy_mask_view.mask_info = GameState.enemy_mask
	enemy_mask_view.element_hovered.connect(_on_mask_element_hovered)
	enemy_mask_view.element_hovered_out.connect(_on_mask_element_hovered_out)
	show_enemy_question()

func hide_popups():
	emplacement_popup.hide()
	caracteristique_popup.hide()
	color_popup.hide()
	forme_popup.hide()

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
	

func show_enemy_question():
	ask_question_ui.hide()
	GameState.try_to_take_a_guess()
		
	var enemy_question := GameState.generate_enemy_question()
	enemy_question_container.show_for_question(enemy_question)
	yes_no_container.show_for_question(enemy_question)
	var player_answer = await yes_no_container.player_answered
	chara_blink_animation_player.play("chara_choc")
	chara_blink_animation_player.queue("chara_blink")
	enemy_question_container.hide()
	yes_no_container.hide()
	GameState.answer_enemy_question(enemy_question, player_answer)
	show_player_ask_interface()

func show_player_ask_interface():
	current_player_question = Question.new()
	question_emplacement_button.icon = null
	question_caracteristique_button.icon = null
	question_value_button.icon = null
	ask_button.disabled = true
	
	ask_question_ui.show()
	await ask_button.pressed
	AudioManager.play_click()
	ask_question_ui.hide()
	await get_tree().create_timer(0.5).timeout
	var enemy_answer := GameState.ask_question_to_enemy(current_player_question)
	if enemy_answer:
		AudioManager.play_enemy_yes()
	else:
		AudioManager.play_enemy_no()
	enemy_answer_container.display_answer(enemy_answer)
	await get_tree().create_timer(2).timeout
	enemy_answer_container.hide()
	show_enemy_question()
	
	
func _on_question_button_pressed(origin_button: Button, destination_button: Button):
	AudioManager.play_click()
	destination_button.icon = origin_button.icon
	destination_button.self_modulate = Color.WHITE
	if origin_button is ButtonItemEmplacement:
		current_player_question.emplacement = origin_button.value
	elif origin_button is ButtonItemCaracteristique:
		if current_player_question.caracteristique != origin_button.value:
			question_value_button.icon = null
			current_player_question.value = ""
		current_player_question.caracteristique = origin_button.value
		question_value_button.disabled = false
	elif origin_button is ButtonItemColor:
		current_player_question.value = origin_button.value
		destination_button.self_modulate = origin_button.self_modulate
	elif origin_button is ButtonItemShape:
		current_player_question.value = origin_button.value
	hide_popups()
	untoggle_buttons(null)
	ask_button.disabled = not current_player_question.is_valid()


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

		if current_player_question.caracteristique.is_empty():
			print("error : impossible d'ouvrir le selecteur de valeur car aucune caracteristique n'est renseignée dans la question")
			# this should not happen
			return
			
		match current_player_question.caracteristique:
			&"couleur":
				color_popup.show()
			&"forme":
				forme_popup.show()
	else:
		color_popup.hide()
		forme_popup.hide()

func _on_mask_element_hovered(element: MaskElement, element_type: String):
	mask_element_tooltip.show_for(element, element_type)

func _on_mask_element_hovered_out():
	mask_element_tooltip.hide()
