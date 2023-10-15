extends Node2D

var enemy_waves = [["slime_enemy","slime_enemy"], ["slime_enemy"], ["slime_enemy","slime_enemy", "slime_enemy"]]
var currently_spawning = false
var current_wave = 0
var total_waves = enemy_waves.size()
var finished_spawning_all = false
var round_won_notified = false
signal start_spawning_enemies 
signal round_won
var enemies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if !finished_spawning_all:
		if !currently_spawning:
			currently_spawning = true
			start_spawning_enemies.emit()
	elif finished_spawning_all and get_node("Enemy Path").get_children().size() == 0 and !round_won_notified:
		round_won.emit()
		round_won_notified = true
		
	
		
		
func spawn(enemy_type):
	if currently_spawning:
		var enemy = load("res://Scenes/Enemies/"+ enemy_type +".tscn").instantiate()
		get_node("Enemy Path").add_child(enemy)
		get_parent().get_node("In game UI").connect_enemy(enemy)
		get_parent().get_node("In game UI").move_child(enemy,0)
		enemies.append(enemy)
		

	



func _on_start_spawning_enemies():
	
	if current_wave < total_waves:
		for enemy in enemy_waves[current_wave]:
			spawn(enemy)
			
			await get_tree().create_timer(2).timeout
		current_wave += 1
		await get_tree().create_timer(10).timeout
		currently_spawning = false
	else: 
		finished_spawning_all = true
		
		


	
	
		
	
	
	
