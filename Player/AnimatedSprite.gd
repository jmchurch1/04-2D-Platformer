extends AnimatedSprite

onready var tween = get_node("Tween")
var health = false


func _process(_delta):
	if Input.is_action_just_pressed("test"):
		tween.interpolate_property(CanvasItem, "shader_param/progress", 0, 1, .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

