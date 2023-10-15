extends "res://Sprites/Turrets/turrets.gd"

var damage = 10
var reloading = false
var reload_time = 0.5


	
func _physics_process(delta):
	if shoot and enemies_in_range.size() !=0:
		turn(enemies_in_range[0].get_parent().get_global_position())
		if !reloading:
			shoot_enemy()
		
	else:
		turn(get_global_mouse_position())
	
		
	


func shoot_enemy():
	reloading = true
	get_node("TurretSprite/AnimationPlayer").play("shoot")
	await get_tree().create_timer(get_node("TurretSprite/AnimationPlayer").current_animation_length).timeout
	if enemies_in_range.size() !=0:
		enemies_in_range[0].get_parent().take_damage(damage)
		await get_tree().create_timer(reload_time).timeout
		reloading=false
	else: reloading = false
	
