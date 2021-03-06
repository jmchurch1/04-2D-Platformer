extends KinematicBody2D


export var speed = 20
export var damage = 10
export var max_constraint = 600.0
export var min_constraint = 1300.0
var direction = 1
var velocity = Vector2.ZERO




func _physics_process(_delta):
	if direction > 0 and position.x  >= max_constraint:
		direction = -1
	if direction < 0 and position.x <= min_constraint:
		direction = 1
	
	velocity.x += direction * speed
	move_and_slide_with_snap(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Ground":
			velocity.x = 0
			direction *= -1
		if collision.collider.name == "Player":
			collision.collider.do_damage(damage)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.do_damage(damage)
