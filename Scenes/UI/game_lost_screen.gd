extends Control

@onready var scene_handler = get_parent().get_parent()
@onready var game_scene = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	var mainmenu = load("res://Scenes/UI/main_menu.tscn").instantiate()
	mainmenu.name = "Main Menu"
	Engine.time_scale = 1
	scene_handler.add_child(mainmenu)
	scene_handler.on_mainmenu_made()
	scene_handler.get_node("Game Scene").queue_free()


func _on_restart_pressed():
	scene_handler.restart_level()
	
	
	
