extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite2D/AnimationPlayer").play("coin_spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
