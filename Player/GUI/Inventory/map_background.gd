extends Background

const EAGLE_MAP = preload("res://Dungeons/01 - Eagle/player_map.tscn")
const MOON_MAP = preload("res://Dungeons/02 - Moon/player_map.tscn")

var player_map : Node

func _ready() -> void:
	super()
	update_player_map()
	
func toggle_graphics( _new_value : bool )->void:
	super( _new_value )
	
func update_player_map() -> void:
	#print ("Player Map")
	for c  in get_children():
		if c is DungeonMap:
			c.queue_free()
	if PlayerManager.dungeon_name == "01 - Eagle":
		player_map = EAGLE_MAP.instantiate()
		add_child(player_map)
	elif PlayerManager.dungeon_name == "02 - Moon":
		player_map = MOON_MAP.instantiate()
		add_child(player_map)
	pass
