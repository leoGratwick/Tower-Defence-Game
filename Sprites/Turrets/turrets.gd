extends Node2D

var enemies_in_range = []
var shoot = false




	
func turn(location):
	get_node("TurretSprite").look_at(location)



func update_position(_position):
	position = _position

func connect_area():
	get_node("Area2D").connect("body_entered", enemy_entered_range)
	get_node("Area2D").connect("body_exited", enemy_exited_range)
	
	print("connected")
	
func enemy_entered_range(enemy):
	enemies_in_range.append(enemy)
	shoot = true
	
	
func enemy_exited_range(enemy):
	enemies_in_range.erase(enemy)
	if enemies_in_range.size()== 0:
		shoot = false
	


	
	
