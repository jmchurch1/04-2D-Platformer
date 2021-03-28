extends Area2D


func _on_Portal_entered(body):
	if body.name == "Player":
		if name == "Portal_to_2":
			Global.level = 1
		if name == "Portal_to_3":
			Global.level = 2
		if Global.level < Global.levels.size():
			get_tree().change_scene(Global.levels[Global.level])



