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
	
	
func game_quit():
	get_tree().quit()
	
func on_mainmenu_made():
	get_node("Main Menu/MarginContainer/VBoxContainer/Quit").connect("pressed", game_quit)
	get_node("Main Menu/MarginContainer/VBoxContainer/NewGame").connect("pressed", new_game_pressed)
	
func restart_level():
	get_child(0).queue_free()
	var new_game_scene = load("res://Scenes/game_scene.tscn").instantiate()
	var map = load("res://Scenes/Maps/Map1.tscn").instantiate()
	map.name = "Map1"
	new_game_scene.name = "Game Scene"
	new_game_scene.add_child(map)
	add_child(new_game_scene)
	Engine.time_scale = 1
