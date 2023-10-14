extends PathFollow2D

var SPEED = 0.05
var time_after_spawn = 5000

@onready var sprite = get_node("CharacterBody2D/Sprite2D")

func _ready():
	print("HELLO THERE")
	get_node("CharacterBody2D/Sprite2D/AnimationPlayer").play("walk")
	

func _physics_process(delta):
	# only moves forward when on frames of enemy in the air
	if sprite.frame == 2 or sprite.frame == 3:
		progress_ratio += SPEED * delta
	
	
	# Wrap the offset back to 0 when it reaches 1 to loop the path
	if progress_ratio >= 1.0:
		queue_free()
