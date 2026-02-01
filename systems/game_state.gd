# GameState (autoload)
extends Node

signal turn_changed
signal player_knowledge_acquired(knowledge: Dictionary) # {Question:bool}
signal player_hp_changed
signal victory
signal gameover

var player_mask: MaskInfo
var enemy_mask: MaskInfo

var is_enemy_turn: bool = false:
	set(value):
		is_enemy_turn = value
		turn_changed.emit()

var player_knowledge: Dictionary[Question, bool] # {Question:bool}
var enemy_knowledge: Dictionary[Question, bool] # {Question:bool}
var player_hp: int = 3 :
	set(value):
		player_hp = clampi(value,0,10)
		player_hp_changed.emit()
var enemy_hp: int = 3

# enemy variables
var trick_question_probability: float = 0
var trick_question_probability_step: float = 0.05
var enemy_sure_masks_probability: float = 0
var enemy_sure_masks_probability_step: float = 0.05
var enemy_last_question: Question
var enemy_sure_masks: Dictionary[String, MaskElementInfo]

func _ready():
	pass

func start_round():
	player_mask = generate_random_mask()
	enemy_mask = generate_random_mask()
	player_knowledge.clear()
	enemy_knowledge.clear()
	player_hp = 3
	enemy_hp = 3
	trick_question_probability = 0
	is_enemy_turn = true

func generate_random_mask() -> MaskInfo:
	var picked_mask = MaskInfo.new()
	picked_mask.bouche_info = MaskElementInfo.new()
	picked_mask.bouche_info.texture_pack = Library.all_bouches_texturepacks.pick_random()
	picked_mask.bouche_info.couleur = get_random_couleur()
	picked_mask.bouche_info.forme = picked_mask.bouche_info.texture_pack.forme
	picked_mask.coiffe_info = MaskElementInfo.new()
	picked_mask.coiffe_info.texture_pack = Library.all_coiffes_texturepacks.pick_random()
	picked_mask.coiffe_info.couleur = get_random_couleur()
	picked_mask.coiffe_info.forme = picked_mask.coiffe_info.texture_pack.forme
	picked_mask.face_info = MaskElementInfo.new()
	picked_mask.face_info.texture_pack = Library.all_faces_texturepacks.pick_random()
	picked_mask.face_info.couleur = get_random_couleur()
	picked_mask.face_info.forme = picked_mask.face_info.texture_pack.forme
	picked_mask.yeux_info = MaskElementInfo.new()
	picked_mask.yeux_info.texture_pack = Library.all_yeux_texturepacks.pick_random()
	picked_mask.yeux_info.couleur = get_random_couleur()
	picked_mask.yeux_info.forme = picked_mask.yeux_info.texture_pack.forme
	return picked_mask

func get_mask_truth(mask: MaskInfo, question: Question) -> bool:
	match question.emplacement:
		&"any":
			return mask.all_elements.any(func(element: MaskElementInfo):
				return element.has_caracteristique_value(question.caracteristique, question.value))
		&"face":
			return mask.face_info.has_caracteristique_value(question.caracteristique, question.value)
		&"coiffe":
			return mask.coiffe_info.has_caracteristique_value(question.caracteristique, question.value)
		&"yeux":
			return mask.yeux_info.has_caracteristique_value(question.caracteristique, question.value)
		&"bouche":
			return mask.bouche_info.has_caracteristique_value(question.caracteristique, question.value)
	return true

func compare_masks(mask1: MaskInfo, mask2: MaskInfo) -> bool:
	return mask1.face_info.forme == mask2.face_info.forme && mask1.coiffe_info.forme == mask2.coiffe_info.forme && mask1.yeux_info.forme == mask2.yeux_info.forme && mask1.bouche_info.forme == mask2.bouche_info.forme && mask1.face_info.couleur == mask2.face_info.couleur && mask1.coiffe_info.couleur == mask2.coiffe_info.couleur && mask1.yeux_info.couleur == mask2.yeux_info.couleur && mask1.bouche_info.couleur == mask2.bouche_info.couleur

func player_submit_solution(mask: MaskInfo):
	var is_right = compare_masks(mask, player_mask)
	if !is_right:
		player_hp -= 1
		if player_hp <= 0:
			print('GAME OVER')
			gameover.emit()
			AudioManager.play_game_over()
		else:
			AudioManager.play_bad_guess()
	else:
		print('VICTORY!')
		victory.emit()
		AudioManager.play_victory()
	

func generate_enemy_question() -> Question:
	var current_question = null
	if randf() < trick_question_probability:
		trick_question_probability = 0
		current_question = generate_enemy_trick_question()
	else:
		# if false: # if sure_mask >= 2
		# 	trick_question_probability += trick_question_probability_step
		current_question = generate_enemy_valid_question()

	enemy_last_question = current_question
	return current_question


func generate_enemy_valid_question() -> Question:
	var question := Question.new()
	var should_generate_new_question = true

	var it = 0
	while should_generate_new_question && it < 100:
		question.emplacement = [&"any", &"face", &"coiffe", &"yeux", &"bouche"].pick_random()
		question.caracteristique = [&"couleur", &"forme"].pick_random()
		match question.caracteristique:
			&"couleur":
				question.value = get_random_couleur()
			&"forme":
				question.value = get_random_forme()

		should_generate_new_question = is_emplacement_caracteristique_sure(question.emplacement, question.caracteristique) != "" || is_question_useless(question)
		it += 1

	if it >= 100:
		print("Enemy generated useless question :(")

	return question

func generate_enemy_trick_question() -> Question:
	var question := Question.new()
	return question

func try_to_take_a_guess() -> MaskInfo:
	if enemy_sure_masks.size() >= 1:
		enemy_sure_masks_probability += enemy_sure_masks_probability_step

	print('proba take a guess ', enemy_sure_masks_probability)
	var r_take_a_guess = randf() < enemy_sure_masks_probability

	if (enemy_sure_masks.size() >= 1 && r_take_a_guess) || enemy_sure_masks.size() == 4:
		var guess_mask = MaskInfo.new()
		if enemy_sure_masks["bouche"] != null:
			guess_mask.bouche_info = enemy_sure_masks["bouche"]
		else:
			guess_mask.bouche_info.couleur = get_random_couleur()
			guess_mask.bouche_info.forme = get_random_forme()
		
		if enemy_sure_masks["coiffe"] != null:
			guess_mask.coiffe_info = enemy_sure_masks["coiffe"]
		else:
			guess_mask.coiffe_info.couleur = get_random_couleur()
			guess_mask.coiffe_info.forme = get_random_forme()

		if enemy_sure_masks["face"] != null:
			guess_mask.face_info = enemy_sure_masks["face"]
		else:
			guess_mask.face_info.couleur = get_random_couleur()
			guess_mask.face_info.forme = get_random_forme()

		if enemy_sure_masks["yeux"] != null:
			guess_mask.yeux_info = enemy_sure_masks["yeux"]
		else:
			guess_mask.yeux_info.couleur = get_random_couleur()
			guess_mask.yeux_info.forme = get_random_forme()

		return guess_mask
	return null

func refresh_enemy_sure_masks():
	enemy_sure_masks.clear()
	var possible_masks: Dictionary
	for emplacement in [&"face", &"coiffe", &"yeux", &"bouche"]:
		possible_masks[emplacement] = {}
		for caracteristique in [&"couleur", &"forme"]:
			possible_masks[emplacement][caracteristique] = {}
			match caracteristique:
				&"couleur":
					for value in [&"red", &"yellow", &"green", &"blue", &"purple"]:
						possible_masks[emplacement][caracteristique][value] = true
				&"forme":
					for value in [&"square", &"triangle", &"round", &"spiky", &"polygon"]:
						possible_masks[emplacement][caracteristique][value] = true
	
	# filter all anything "no" knowledge
	for question in enemy_knowledge:
		if question.emplacement == "any" and enemy_knowledge[question] == false:
			for emplacement in [&"face", &"coiffe", &"yeux", &"bouche"]:
				possible_masks[emplacement][question.caracteristique][question.value] = false

	# check specific parts questions
	for question in enemy_knowledge:
		if question.emplacement != "any" and enemy_knowledge[question] and !possible_masks[question.emplacement][question.caracteristique][question.value]:
			# TODO: Player is lying!!!
			print("Player is lying!!!")
		if question.emplacement != "any" and !enemy_knowledge[question]:
			possible_masks[question.emplacement][question.caracteristique][question.value] = false
				
	# save sure masks
	for emplacement in [&"face", &"coiffe", &"yeux", &"bouche"]:
		var is_sure_color = is_emplacement_caracteristique_sure(emplacement, &"couleur")
		var is_sure_forme = is_emplacement_caracteristique_sure(emplacement, &"forme")
		if is_sure_color != "" && is_sure_forme != "":
			var mask_element = MaskElementInfo.new()
			mask_element.forme = is_sure_forme
			mask_element.couleur = is_sure_color
			enemy_sure_masks[emplacement] = mask_element
			print("I'm sure of element ", emplacement, " with color ", is_sure_color, " and form ", is_sure_forme)

	print("Sure masks amount: ", enemy_sure_masks.size())
	if enemy_sure_masks.size() == 4:
		print("OMG I'm sure I found the mask!")
		
			
func is_emplacement_caracteristique_sure(emplacement: String, caracteristique: String) -> String:
	# check direct question
	for question in enemy_knowledge:
		if question.emplacement == emplacement and question.caracteristique == caracteristique and enemy_knowledge[question]:
			return question.value
	
	# check if all other values for that emplacement and caracteristique are false
	var possible_values = []
	match caracteristique:
		&"couleur":
			possible_values = [&"red", &"yellow", &"green", &"blue", &"purple"]
		&"forme":
			possible_values = [&"square", &"triangle", &"round", &"spiky", &"polygon"]
	for question in enemy_knowledge:
		if (question.emplacement == emplacement or question.emplacement == "any") and question.caracteristique == caracteristique and !enemy_knowledge[question]:
			if question.value in possible_values:
				possible_values.erase(question.value)
				
	# only one value left
	if possible_values.size() == 1:
		return possible_values[0]

	if possible_values.size() == 0:
		print("y'a un problème là, il n'y a plus de valeur possible pour ", emplacement, " et ", caracteristique)
		return ""

	# we don't check "anything true" questions for now
	return ""

# check if the element is already known, whether it's true or false
func is_question_useless(new_question: Question) -> bool:
	for question_knowledge in enemy_knowledge:
		# if the question was already asked
		if question_knowledge.emplacement == new_question.emplacement and question_knowledge.caracteristique == new_question.caracteristique && question_knowledge.value == new_question.value:
			return true

		# if the question was already asked with "any"
		if question_knowledge.emplacement == "any" and question_knowledge.caracteristique == new_question.caracteristique && question_knowledge.value == new_question.value && !enemy_knowledge[question_knowledge]:
			return true


	return false
				
func ask_question_to_enemy(question: Question) -> bool:
	var answer := get_mask_truth(player_mask, question)
	var new_knowledge := {question: answer}
	player_knowledge[question] = answer
	player_knowledge_acquired.emit(new_knowledge)
	is_enemy_turn = true
	return answer

func answer_enemy_question(question: Question, answer: bool):
	enemy_knowledge[question] = answer
	is_enemy_turn = false

	refresh_enemy_sure_masks()

func submit_player_solution(mask: Mask) -> bool:
	return player_mask.is_equivalent_to(mask)

func get_random_couleur() -> String:
	return ["red", "yellow", "green", "blue", "purple"].pick_random()

func get_random_forme() -> String:
	return ["square", "triangle", "round", "spiky", "polygon"].pick_random()
