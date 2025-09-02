class_name HudMap extends Node2D

@onready var nes_map: TileMapLayer = $Map
@onready var snes_map: TileMapLayer = $SNESMap
@onready var link: TileMapLayer = $Link
@onready var compass: TileMapLayer = $Compass

@export var map_item : ItemData
@export var compass_item : ItemData

var map


func _ready() -> void:
	LevelManager.level_loaded.connect(level_ready)
	Events.dungeon_map_update.connect (level_ready)
	Events.dungeon_map_cords.connect (move_link)
	Events.toggle_graphics.connect(toggle_graphics)

func level_ready()->void:	
	if PlayerManager.in_dungeon:
		toggle_graphics(PlayerManager.upgraded_graphics)
		visible=true
		link.visible=true
		if PlayerManager.inventory.contents.has(compass_item.name):
			compass.visible=true
		else: 
			compass.visible=false
	else:
		visible=false
		return

func move_link (x : int, y : int) -> void:
	link.position=Vector2(x*8,y*4)

func toggle_graphics( _new_value : bool )->void:
	if !PlayerManager.in_dungeon:
		return
	if _new_value:
		map = snes_map
	else:
		map = nes_map
	nes_map.visible=false
	snes_map.visible=false
	if PlayerManager.inventory.contents.has(map_item.name):
		map.visible=true
	else: 
		map.visible=false
