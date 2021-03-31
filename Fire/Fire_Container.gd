extends Node2D

onready var Fire = load("res://Fire/Fire.tscn")
func spawn(p):
	var fire = Fire.instance()
	fire.position = p
	add_child(fire)
