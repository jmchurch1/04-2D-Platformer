extends Node2D

onready var Fire = load("res://Fire/Fire.tscn")
func spawn(attr, p):
	var fire = Fire.instance()
	for a in attr:
		fire[a] = attr[a]
	fire.position = p
