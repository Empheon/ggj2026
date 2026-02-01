# AudioManager (Autoload)
extends Node

@export var click: AudioStreamPlayer
@export var say_yes: AudioStreamPlayer
@export var say_no: AudioStreamPlayer
@export var enemy_yes: AudioStreamPlayer
@export var enemy_no: AudioStreamPlayer
@export var bad_guess: AudioStreamPlayer
@export var victory: AudioStreamPlayer
@export var game_over: AudioStreamPlayer

func play_click():
	click.play()

func play_say_yes():
	say_yes.play()

func play_say_no():
	say_no.play()

func play_enemy_yes():
	enemy_yes.play()

func play_enemy_no():
	enemy_no.play()

func play_bad_guess():
	bad_guess.play()

func play_victory():
	victory.play()

func play_game_over():
	game_over.play()
