extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var path_follow = get_parent().get_node("Enemy Path/PathFollow2D")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	pass

func _physics_process(delta):
	# Move the KinematicBody2D along the path
	path_follow.progress += SPEED * delta
	
	# Wrap the offset back to 0 when it reaches 1 to loop the path
	if path_follow.progress >= 1.0:
		path_follow.progress = 0.0
	# Add the gravity.
	
