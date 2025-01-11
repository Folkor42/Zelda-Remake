extends Node2D

const bomb = preload("res://Items/bomb.tscn")
@onready var parent : Node = get_parent().get_parent().get_parent()

func _ready() -> void:
	Events.bomb_used.connect (place_bomb)
	
func place_bomb()->void:
	if PlayerManager.bombs < 1:
		print ("You have no bombs!")
		return
	# We have bombs
	PlayerManager.update_bombs(-1)
	var facing : Vector2
	if PlayerManager.player.cardinal_direction==Vector2.UP:
		facing = Vector2(0,-16)
	elif PlayerManager.player.cardinal_direction==Vector2.DOWN:
		facing = Vector2(0,16)
	elif PlayerManager.player.cardinal_direction==Vector2.LEFT:
		facing = Vector2(-16,0)
	elif PlayerManager.player.cardinal_direction==Vector2.RIGHT:
		facing = Vector2(16,0)
	var new_bomb = bomb.instantiate()
	new_bomb.global_position=PlayerManager.player.global_position + facing
	parent.add_child(new_bomb)
