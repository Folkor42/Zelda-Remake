extends Node2D

const fire = preload("res://Items/candle_fire.tscn")
var parent : Node
@export var red_candle : bool = false

@onready var timer: Timer = $Timer


func _ready() -> void:
	Events.candle_used.connect (cast_fire)
	parent = get_parent().get_parent().get_parent().get_parent()
	if red_candle:
		timer.wait_time=1
	
func cast_fire()->void:
	if !timer.is_stopped():
		print ("You can't cast yet")
		return
	# We can cast fire
	timer.start()
	var facing : Vector2
	if PlayerManager.player.cardinal_direction==Vector2.UP:
		facing = Vector2(0,-16)
	elif PlayerManager.player.cardinal_direction==Vector2.DOWN:
		facing = Vector2(0,16)
	elif PlayerManager.player.cardinal_direction==Vector2.LEFT:
		facing = Vector2(-16,0)
	elif PlayerManager.player.cardinal_direction==Vector2.RIGHT:
		facing = Vector2(16,0)
	var new_fire = fire.instantiate()
	new_fire.global_position=PlayerManager.player.global_position + facing
	parent.add_child(new_fire)
