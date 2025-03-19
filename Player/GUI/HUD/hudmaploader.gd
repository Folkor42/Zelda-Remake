extends Control

const EAGLE_MAP = preload("res://Dungeons/01 - Eagle/hud_map.tscn")
const MOON_MAP = preload("res://Dungeons/02 - Moon/hud_map.tscn")

var player_map : Node

func _ready() -> void:
	Events.dungeon_entered.connect(update_hud_map)
	
func update_hud_map(dungeon_name)->void:
	print ("Updating Hud Map")
	for c  in get_children():
		if c is HudMap:
			c.queue_free()
	if dungeon_name == "01 - Eagle":
		player_map = EAGLE_MAP.instantiate()
		add_child(player_map)
	else:
		player_map = MOON_MAP.instantiate()
		add_child(player_map)
	pass
