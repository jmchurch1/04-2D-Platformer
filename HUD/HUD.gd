extends Node2D


func _physics_process(_delta):
	$Score.text = str(Global.score)
	$Lives.text = str(Global.lives)
	$Health.text = str(Global.health)
