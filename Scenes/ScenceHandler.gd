extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	on_mainmenu_made()
	

func new_game_pressed():
	get_node("Main Menu").queue_free()
	var map = load("res://Scenes/Maps/Map1.tscn").instantiate()
	var game_scene = load("res://Scenes/game_scene.tscn").instantiate()
	game_scene.add_child(map)
	add_child(game_scene)
	get_tree().paused = true
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func game_quit():
	get_tree().quit()
	
func on_mainmenu_made():
	get_node("Main Menu/MarginContainer/VBoxContainer/Quit").connect("pressed", game_quit)
	get_node("Main Menu/MarginContainer/VBoxContainer/NewGame").connect("pressed", new_game_pressed)
	