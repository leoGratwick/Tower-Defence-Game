extends Node2D

var build_mode = false
@onready var map_node = get_node("Map1")
@onready var exclusion_map = map_node.get_node("Exclusion Map")
var build_valid = false
var current_building 





# Called when the node enters the scene tree for the first time.

	
func _ready():
	get_node("In game UI").z_index = 11
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if build_mode:
		update_building_preview()


func build_mode_on():
	build_mode = true	
	
	

	
	
func update_building_preview():
	
	var mouse_pos = get_viewport().get_mouse_position()/4
	var tile_pos = exclusion_map.local_to_map(mouse_pos)
	var tile_data = exclusion_map.get_cell_tile_data(0, tile_pos)
	if build_mode:
		if tile_data is TileData:
			#print(tile_data.get_texture_origin())
			build_valid = false
			get_node("In game UI").update_build_preview(mouse_pos*4, "#ff150ead", false)
		else:
			build_valid = true
			get_node("In game UI").update_build_preview(mouse_pos*4, "#47ff007b", true)
		
	
func _input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		get_node("In game UI").validate_and_build()
	elif event.is_action_released("ui_accept") and build_mode == true:
		get_node("In game UI").cancel_build_mode()
		build_mode = false





