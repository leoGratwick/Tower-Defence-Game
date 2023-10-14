extends Control

@onready var scene_handler = get_parent().get_parent()
@onready var game_scene = get_parent()
var build_valid = false
var building_name 
var build_mode = false


func _on_exit_pressed():
	var mainmenu = load("res://Scenes/UI/main_menu.tscn").instantiate()
	mainmenu.name = "Main Menu"
	Engine.time_scale = 1
	scene_handler.add_child(mainmenu)
	scene_handler.on_mainmenu_made()
	scene_handler.get_node("Game Scene").queue_free()
	



func _on_play_pause_pressed():
	get_tree().paused = !get_tree().paused
	pass


func _on_fast_forward_pressed():
	if Engine.time_scale == 1:
		Engine.time_scale = 4
	else:
		Engine.time_scale = 1
		
		
func _on_red_turret_pressed():
	cancel_build_mode()
	start_build_preview_mode("red_turret")
	


func _on_blue_turret_pressed():
	cancel_build_mode()
	start_build_preview_mode("blue_turret")
	
	
func start_build_preview_mode(building__name):
	building_name = building__name
	build_mode = true
	game_scene.build_mode_on()
	var building = load("res://Scenes/Turrets/"+ building_name+".tscn").instantiate()
	building.name = "DragTower"
	building.get_node("TurretRange").show()
	var control = Control.new()
	control.modulate = Color("#47ff007b")
	control.name = "BuildingPreview"
	control.add_child(building)
	control.process_mode = Node.PROCESS_MODE_ALWAYS
	game_scene.add_child(control)
	control.z_index = 10
	

func update_build_preview(build_position, colour, validity):
	if build_mode:
		build_valid = validity
		game_scene.get_node("BuildingPreview/DragTower").update_position(build_position)
		game_scene.get_node("BuildingPreview").modulate = Color(colour)
	

func validate_and_build():
	if build_valid:
		var building = load("res://Scenes/Turrets/"+ building_name+".tscn").instantiate()
		building.z_index = 5
		building.position = game_scene.get_node("BuildingPreview/DragTower").position
		game_scene.add_child(building)
		cancel_build_mode()
	
	
func cancel_build_mode():
	if build_mode:
		build_mode = false
		build_valid = false
		game_scene.build_mode = false
		game_scene.get_node("BuildingPreview").free()
		
	

