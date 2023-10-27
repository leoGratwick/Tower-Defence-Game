extends Control

@onready var scene_handler = get_parent().get_parent()
@onready var game_scene = get_parent()
var build_valid = false
var building_name 
var build_mode = false
var money = 50
var red_price = 20
var blue_price = 30
var health = 100
var lost = false


func _ready():
	get_node("MarginContainer/HealthBar").max_value = health
	get_node("MarginContainer/VBoxContainer/HBoxContainer/Control/Coin/Sprite2D/AnimationPlayer").speed_scale = 1
	game_scene.get_child(1).connect("round_won", game_won)
	
func _physics_process(_delta):
	get_node("MarginContainer/VBoxContainer/HBoxContainer/Money").text = str(money)
	get_node("MarginContainer/HealthBar").value = health

func _on_exit_pressed():
	var mainmenu = load("res://Scenes/UI/main_menu.tscn").instantiate()
	mainmenu.name = "Main Menu"
	Engine.time_scale = 1
	scene_handler.add_child(mainmenu)
	scene_handler.on_mainmenu_made()
	scene_handler.get_child(0).queue_free()
	



func _on_play_pause_pressed():
	get_tree().paused = !get_tree().paused
	var enemies = game_scene.get_child(1).enemies
	if get_tree().paused:
		for enemy in enemies:
			if enemy is PathFollow2D:
				enemy.disable_collision()
	else:
		for enemy in enemies:
			if enemy is PathFollow2D:
				enemy.enable_collision()
	PhysicsServer2D.set_active(true)
	


func _on_fast_forward_pressed():
	if Engine.time_scale == 1:
		Engine.time_scale = 4
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Control/Coin/Sprite2D/AnimationPlayer").speed_scale = 0.25
	else:
		Engine.time_scale = 1
		get_node("MarginContainer/VBoxContainer/HBoxContainer/Control/Coin/Sprite2D/AnimationPlayer").speed_scale = 1
		
		
func _on_red_turret_pressed():
	cancel_build_mode()
	start_build_preview_mode("red_turret")
	


func _on_blue_turret_pressed():
	cancel_build_mode()
	start_build_preview_mode("blue_turret")
	
	
func start_build_preview_mode(building__name):
	physics_true()
	building_name = building__name
	build_mode = true
	game_scene.build_mode_on()
	var building = load("res://Scenes/Turrets/"+ building_name+".tscn").instantiate()
	building.name = "DragTower"
	building.get_node("Area2D/TurretRange").show()
	building.position = get_global_mouse_position()
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
		var price
		if building_name == "red_turret":
			price = red_price
		else: price = blue_price
		if money >= price:
			var building = load("res://Scenes/Turrets/"+ building_name+".tscn").instantiate()
			building.z_index = 5
			building.position = game_scene.get_node("BuildingPreview/DragTower").position
			game_scene.add_child(building)
			building.connect_area()
			money -= price
		else:
			not_enough_money()
		cancel_build_mode()
	
	
func cancel_build_mode():
	if build_mode:
		build_mode = false
		build_valid = false
		game_scene.build_mode = false
		game_scene.get_node("BuildingPreview").free()
		
	
	
func not_enough_money():
	var popup = load("res://Scenes/UI/NotEnoughMoney.tscn").instantiate()
	popup.position = get_viewport_rect().size / 2
	game_scene.add_child(popup)
	await get_tree().create_timer(1).timeout
	game_scene.get_node("NotEnoughMoney").queue_free()
	

func connect_enemy(enemy):
	enemy.connect("enemy_progressed", take_damage)
	enemy.connect("enemy_killed", enemy_killed)


func take_damage(damage):
	if health - damage > 0 :
		health -= damage
	else: 
		lost = true
		game_lost()
		health = 0
	
func enemy_killed(reward):
	money += reward

func game_lost():
	game_scene.game_over = true
	print("lost game")
	get_tree().paused = true
	var game_lost_screen = load("res://Scenes/UI/game_lost_screen.tscn").instantiate()
	game_lost_screen.position = get_viewport_rect().size / 2
	game_scene.add_child(game_lost_screen)
	queue_free()
	
func game_won():
	game_scene.game_over = true
	get_tree().paused = true
	var game_won_screen = load("res://Scenes/UI/game_lost_screen.tscn").instantiate()
	game_won_screen.position = get_viewport_rect().size / 2
	game_won_screen.get_node("MarginContainer/HBoxContainer3/Label").text = "You Won"
	game_won_screen.get_node("MarginContainer/HBoxContainer3/Label").label_settings = load("res://Fonts/game_won_screen.tres")
	game_scene.add_child(game_won_screen)
	queue_free()
	
func physics_true():
	PhysicsServer2D.set_active(true)
	
	

