extends Area2D

var score = 1

func _on_Fire_body_entered(body):
	if body.name == "Player":
		Global.increase_score(score)
		queue_free()
