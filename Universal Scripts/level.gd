class_name Level extends Node2D

#const PICKUP = preload("res://Items/Item_pickup/item_pickup.tscn")
@export var music : AudioStream
@export var dungeon_camera: Camera2D
@export var dungeon_name : String = "01 - Eagle"

var scene : String

func _ready():
	PlayerManager.player.collision_shape_2d.disabled=true
	PlayerManager.player.remove_camera()
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	LevelManager.level_load_started.connect( _free_level )
	#AudioManager.play_music( music )
	scene = get_tree().current_scene.scene_file_path
	#check_for_previous_drops()
	LevelManager.level_loaded.connect(level_ready)
	PlayerManager.in_dungeon = true
	PlayerManager.dungeon_name = dungeon_name
	Events.dungeon_entered.emit(dungeon_name)
	pass

func level_ready()->void:
	if dungeon_camera:
		dungeon_camera.position_smoothing_enabled=true
	PlayerManager.player.collision_shape_2d.disabled=false
	pass

func _free_level() -> void:
	PlayerManager.unparent_player ( self )
	queue_free()
	pass

#func check_for_previous_drops():
	#var drops = SaveManager.current_save.drops
	#for i in range(drops.size(), 0, -1):
		#var d = SaveManager.current_save.drops[i-1]
		#if d["scene"] == scene:
			#add_drop(d["item_data"],d["pos_x"],d["pos_y"])
			#SaveManager.current_save.drops.erase(d)
	#var saved_drops = SaveManager.current_save.saved_drops
	#for i in range(saved_drops.size(), 0, -1):
		#var d = SaveManager.current_save.saved_drops[i-1]
		#if d["scene"] == scene:
			#print ("Found SAVED item for this scene.")
			#d["item_data"]=parse_save_data(d["item"])
			#add_drop(d["item_data"],d["posx"],d["posy"])
			#SaveManager.current_save.saved_drops.erase(d)
	#pass
#
#func add_drop( item, pos_x, pos_y) -> void:
	#var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
	#drop.item_data = item
	#call_deferred( "add_child", drop )
	#drop.global_position = Vector2(pos_x,pos_y)
#
#func parse_save_data ( res_name : String ) -> ItemData:
	#print (res_name)
	#var item = item_from_save( res_name )
	#print (item)
	#return item
	#
#func item_from_save ( save_object : String ) -> ItemData:
	#var item = load( save_object )
	#return item
