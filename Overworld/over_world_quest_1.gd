extends Node

var dungeon1 = preload("res://Dungeons/01 - Eagle/Dungeon_Map.tscn")

@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	
	camera_2d.reparent(PlayerManager.player)
	pass
