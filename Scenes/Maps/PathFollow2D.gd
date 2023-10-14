extends PathFollow2D

var SPEED = 0.05
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += SPEED * delta
	print(progress_ratio)
	
	# Wrap the offset back to 0 when it reaches 1 to loop the path
	if progress_ratio >= 1.0:
		progress_ratio = 0.0
