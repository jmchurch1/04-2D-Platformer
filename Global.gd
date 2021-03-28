extends Node

var score = 0
var lives = 5
var level = 1
var max_live = 5
var max_health = 100
var health = 100

var levels = [
	"res://Levels/Level1.tscn"
	,"res://Levels/Level2.tscn"
	,"res://Levels/Level3.tscn"
]

var saves = [
	"user://game-data_0.json"
]


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true

func _process(_delta):
	if Input.is_action_pressed("quit"):	
		get_tree().quit()

func increase_score(s):
	score += s

func decrease_health(h):
	health -= h

func decrease_lives(l):
	lives -= l
	health = 100
	if lives <= 0:
		get_tree().change_scene("res://Levels/Game_Over.tscn")

func get_save_data():
	var data = {
		"score":score
		,"lives":lives
		,"health":health
		,"level":level
		,"player":""
		,"enemy_ground":[]
		,"enemy_flying":[]
		,"fire":[]
	}
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		data["player"] = var2str(player.position)
	var enemies = get_node("/root/Game/Enemy_Container").get_children()
	for e in enemies:
		if e.is_in_group("Enemy_Ground"):
			var temp = {"position":var2str(e.position), "max_constraint":e.max_constraint, "min_constraint":e.min_constraint}
			data["enemy_ground"].append(temp)
		if e.is_in_group("Enemy_Flying"):
			var temp = {"position":var2str(e.position)}
			data["enemy_flying"].append(temp)
	var fire = get_node("/root/Game/Fire_Container").get_children()
	for f in fire:
		var temp = {"position":var2str(f.position), "score":f.score}
		data["fire"].append(temp)
	return data




func load_save_data(data):
	score = data["score"]
	lives = data["lives"]
	health = data["health"]
	level = data["level"]
	
	
	if data["player"] != "":
		var player = get_node_or_null("/root/Game/Player_Container/Player")
		if player != null:
			player.name = "Player2"
			player.queue_free()
		get_node("/root/Game/Player_Container").spawn(str2var(data["player"]))
	var enemy_container = get_node("/root/Game/Enemy_Container")
	for e in enemy_container.get_children():
		e.queue_free()
	for e in data["enemy_ground"]:
		var attr = {"max_contraint":e["max_constraint"], "min_constraint":e["min_constraint"]}
		enemy_container.spawn("Enemy_Ground", attr, str2var(e["position"]))
	for e in data["enemy_flying"]:
		var attr = {}
		enemy_container.spawn("Enemy_Flying", attr, str2var(e["position"]))
	var fire_container = get_node("/root/Game/Fire_Container")
	for f in fire_container.get_children():
		f.queue_free()
	for f in data["fire"]:
		var attr = {"score":f["score"]}
		fire_container.spawn(attr, str2var(f["position"]))
	
		
	

func save_game(which_file):
	var file = File.new()
	var data = get_save_data()
	file.open(saves[which_file], File.WRITE)
	file.store_string(to_json(data))
	file.close()

func load_game(which_file):
	var file = File.new()
	if file.file_exists(saves[which_file]):
		file.open(saves[which_file], File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			load_save_data(data)
		else:
			printerr("Corrupted Data")
	else:
		printerr("No saved data")
			
