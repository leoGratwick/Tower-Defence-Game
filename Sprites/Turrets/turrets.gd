extends Node2D


func _physics_process(delta):
	turn()
	
	
func turn():
	var enemy_location = get_global_mouse_position()
	get_node("TurretSprite").look_at(enemy_location)

#func _input(event):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#get_node("TurretSprite/AnimationPlayer").play("shoot")

func update_position(_position):
	position = _position

