extends PathFollow2D

var SPEED = 0.05
var time_after_spawn = 5000
signal enemy_progressed
signal enemy_killed 
var damage = 20
var health = 50
var money_for_killing = 3


@onready var sprite = get_node("CharacterBody2D/Sprite2D")

func _ready():
	get_node("CharacterBody2D/Sprite2D/AnimationPlayer").play("walk")
	get_node("Control/TextureProgressBar").max_value = health
	

func _physics_process(delta):
	get_node("Control/TextureProgressBar").value = health
			
	# only moves forward when on frames of enemy in the air
	if progress_ratio >= 0.99:
		get_parent().get_parent().enemies.erase(self)
		queue_free()
		enemy_progressed.emit(damage)
		
	elif  health != 0 and (sprite.frame == 2 or sprite.frame == 3) :
		progress_ratio += SPEED * delta
	
	
func take_damage(damage):
	if health - damage > 0 :
		health -= damage
	else: 
		health = 0
		death()
		

func death():
	enemy_killed.emit(money_for_killing)
	get_parent().get_parent().enemies.erase(self)
	print(self)
	get_node("CharacterBody2D/Sprite2D").hide()
	get_node("DeathSprite").show()
	get_node("DeathSprite/AnimationPlayer").play("death")
	get_node("CharacterBody2D").queue_free()
	await get_tree().create_timer(get_node("DeathSprite/AnimationPlayer").current_animation_length).timeout
	queue_free()
	
func disable_collision():
	get_node("CharacterBody2D/CollisionShape2D").disabled = true
	
func enable_collision():
	get_node("CharacterBody2D/CollisionShape2D").disabled = false
	
