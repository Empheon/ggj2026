# GameState (autoload)
extends Node

signal turn_changed

var available_masks : Array[Mask]

var player_mask : Mask
var enemy_mask : Mask

var is_enemy_turn : bool = false :
	set(value):
		is_enemy_turn = value
		turn_changed.emit()

var player_knowledge : Array[Dictionary] # {Question:bool}
var enemy_knowledge : Array[Dictionary] # {Question:bool}
var player_hp : int = 3
var enemy_hp : int = 3

func _ready():
	available_masks.assign(Library.all_masks)

func start_round():
	player_mask = pick_mask()
	enemy_mask = pick_mask()
	player_knowledge.clear()
	enemy_knowledge.clear()
	player_hp = 3
	enemy_hp = 3
	is_enemy_turn = true

func pick_mask() -> Mask:
	if available_masks.is_empty():
		available_masks.assign(Library.all_masks)
	var picked_mask : Mask = available_masks.pick_random()
	available_masks.erase(picked_mask)
	return picked_mask

func get_mask_truth(mask:Mask, question:Question) -> bool:
	match question.emplacement:
		&"any":
			return mask.all_elements.any(func(element:MaskElement): 
				return element.has_caracteristique_value(question.caracteristique,question.value))
		&"face":
			return mask.face.has_caracteristique_value(question.caracteristique,question.value)
		&"coiffe":
			return mask.coiffe.has_caracteristique_value(question.caracteristique,question.value)
		&"yeux":
			return mask.yeux.has_caracteristique_value(question.caracteristique,question.value)
		&"nez":
			return mask.nez.has_caracteristique_value(question.caracteristique,question.value)
		&"bouche":
			return mask.bouche.has_caracteristique_value(question.caracteristique,question.value)
	return true

func generate_enemy_question() -> Question:
	var question := Question.new()
	question.emplacement = [&"any", &"face", &"coiffe", &"yeux", &"nez", &"bouche"].pick_random()
	question.caracteristique = [&"couleur", &"forme", &"matiere"].pick_random()
	match question.caracteristique:
		&"couleur":
			question.value = MaskElement.COULEUR.values().pick_random()
		&"forme":
			question.value = MaskElement.FORME.values().pick_random()
		&"matiere":
			question.value = MaskElement.MATIERE.values().pick_random()
	return question

func ask_question_to_enemy(question:Question) -> bool:
	var answer := get_mask_truth(player_mask, question)
	player_knowledge.append({question:answer})
	is_enemy_turn = true
	return answer

func answer_enemy_question(question:Question, answer:bool):
	enemy_knowledge.append({question:answer})
	is_enemy_turn = false

func submit_player_solution(mask:Mask) -> bool:
	return player_mask.is_equivalent_to(mask)
