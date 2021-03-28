extends Node

var blues_music = load("res://Assets/Blues.ogg")


func _ready():
	pass


func play_music():
	$Music.stream = blues_music
	$Music.play()
