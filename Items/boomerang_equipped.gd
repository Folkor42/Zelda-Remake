extends Node2D

const boomerang = preload("res://Items/Boomerang.tscn")
var parent : Node

func _ready() -> void:
	Events.boomerang_used.connect (throw)
	parent = get_parent().get_parent()
	
func throw()->void:
	var rot = deg_to_rad(0)
	var new_boomerang = boomerang.instantiate()
	new_boomerang.position = PlayerManager.player.position
	new_boomerang.rotation = rot
	new_boomerang.direction = PlayerManager.player.cardinal_direction
	parent.add_child(new_boomerang)
