extends Node2D

@onready var map: TileMapLayer = $Map
@onready var link: TileMapLayer = $Link
@onready var compass: TileMapLayer = $Compass

func _ready() -> void:
	LevelManager.level_loaded.connect(level_ready)
	Events.dungeon_map_update.connect (level_ready)

func level_ready()->void:	
	if PlayerManager.in_dungeon:
		link.visible=true
		if PlayerManager.inventory.contents.has("Map"):
			map.visible=true
		else: 
			map.visible=false

		if PlayerManager.inventory.contents.has("Compass"):
			compass.visible=true
		else: 
			compass.visible=false
	else:
		map.visible=false
		compass.visible=false
		link.visible=false
