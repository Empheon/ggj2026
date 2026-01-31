# GameState (autoload)
extends Node

signal turn_changed

var available_masks : Array[Mask]

var player_mask : MaskInfo
var enemy_mask : MaskInfo

var is_enemy_turn : bool = false :
	set(value):
		is_enemy_turn = value
		turn_changed.emit()

var player_knowledge : Array[Dictionary] # {Question:bool}
var enemy_knowledge : Array[Dictionary] # {Question:bool}
var player_hp : int = 3
var enemy_hp : int = 3

func _ready():
	pass

func start_round():
	player_mask = generate_random_mask()
	enemy_mask = generate_random_mask()
	player_knowledge.clear()
	enemy_knowledge.clear()
	player_hp = 3
	enemy_hp = 3
	is_enemy_turn = true

func generate_random_mask() -> MaskInfo:
	var picked_mask = MaskInfo.new()
	picked_mask.bouche_info = MaskElementInfo.new()
	picked_mask.bouche_info.texture_pack = Library.all_bouches_texturepacks.pick_random()
	picked_mask.bouche_info.couleur = get_random_couleur()
	picked_mask.bouche_info.forme = picked_mask.bouche_info.texture_pack.forme
	picked_mask.bouche_info.matiere = get_random_matiere()
	picked_mask.coiffe_info = MaskElementInfo.new()
	picked_mask.coiffe_info.texture_pack = Library.all_coiffes_texturepacks.pick_random()
	picked_mask.coiffe_info.couleur = get_random_couleur()
	picked_mask.coiffe_info.forme = picked_mask.coiffe_info.texture_pack.forme
	picked_mask.coiffe_info.matiere = get_random_matiere()
	picked_mask.face_info = MaskElementInfo.new()
	picked_mask.face_info.texture_pack = Library.all_faces_texturepacks.pick_random()
	picked_mask.face_info.couleur = get_random_couleur()
	picked_mask.face_info.forme = picked_mask.face_info.texture_pack.forme
	picked_mask.face_info.matiere = get_random_matiere()
	picked_mask.nez_info = MaskElementInfo.new()
	picked_mask.nez_info.texture_pack = Library.all_nezs_texturepacks.pick_random()
	picked_mask.nez_info.couleur = get_random_couleur()
	picked_mask.nez_info.forme = picked_mask.nez_info.texture_pack.forme
	picked_mask.nez_info.matiere = get_random_matiere()
	picked_mask.yeux_info = MaskElementInfo.new()
	picked_mask.yeux_info.texture_pack = Library.all_yeux_texturepacks.pick_random()
	picked_mask.yeux_info.couleur = get_random_couleur()
	picked_mask.yeux_info.forme = picked_mask.yeux_info.texture_pack.forme
	picked_mask.yeux_info.matiere = get_random_matiere()
	return picked_mask

func get_mask_truth(mask:MaskInfo, question:Question) -> bool:
	match question.emplacement:
		&"any":
			return mask.all_elements.any(func(element:MaskElementInfo): 
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
			question.value = get_random_couleur()
		&"forme":
			question.value = get_random_forme()
		&"matiere":
			question.value = get_random_matiere()
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

func get_random_couleur() -> String:
	return ["red", "yellow", "green", "blue", "purple"].pick_random()

func get_random_forme() -> String:
	return ["square", "triangle", "round", "spiky", "polygon"].pick_random()

func get_random_matiere() -> String:
	return ["plastic", "wood", "metal", "fur", "rock"].pick_random()
