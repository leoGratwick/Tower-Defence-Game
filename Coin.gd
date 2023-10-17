extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite2D/AnimationPlayer").play("coin_spin")


