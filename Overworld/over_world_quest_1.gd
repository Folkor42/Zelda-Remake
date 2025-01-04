class_name Overworld extends Node2D

#var dungeon1 = preload("res://Dungeons/01 - Eagle/Dungeon_Map.tscn")
#const PICKUP = preload("res://Items/Item_pickup/item_pickup.tscn")
@export var music : AudioStream
@onready var camera_2d: Camera2D = $OverworldCamera

var scene : String

func _ready():
	camera_2d.reparent(PlayerManager.player)
	camera_2d.global_position=PlayerManager.player.global_position
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	LevelManager.level_load_started.connect( _free_level )
	#AudioManager.play_music( music )
	scene = get_tree().current_scene.scene_file_path
	#check_for_previous_drops()
	pass

func _free_level() -> void:
	PlayerManager.unparent_player ( self )
	queue_free()
	pass
	
