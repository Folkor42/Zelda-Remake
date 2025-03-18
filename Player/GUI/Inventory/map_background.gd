extends TextureRect

const EAGLE_MAP = preload("res://Dungeons/01 - Eagle/player_map.tscn")
const MOON_MAP = preload("res://Dungeons/02 - Moon/player_map.tscn")

var player_map : Node

func _ready() -> void:
	change_map(PlayerManager.dungeon_name)
		
func change_map(dungeon_name) -> void:
	print ("Changing Maps")
	for c in get_children():
		c.queue_free()
	if dungeon_name == "01 - Eagle":
		player_map = EAGLE_MAP.instantiate()
		add_child(player_map)
	else:
		player_map = MOON_MAP.instantiate()
		add_child(player_map)
	pass
