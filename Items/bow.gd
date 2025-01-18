extends Node2D

const arrow = preload("res://Items/arrow.tscn")
var parent : Node

func _ready() -> void:
	Events.bow_used.connect (shoot_arrow)
	parent = get_parent().get_parent()
	
func shoot_arrow()->void:
	if PlayerManager.rubies < 1:
		print ("You have no money to shoot!")
		return
	# We have "arrows"
	PlayerManager.update_rubies(-1)
	var rot = deg_to_rad(0)
	if PlayerManager.player.cardinal_direction==Vector2.UP:
		rot = deg_to_rad(270)
	elif PlayerManager.player.cardinal_direction==Vector2.DOWN:
		rot = deg_to_rad(90)
	elif PlayerManager.player.cardinal_direction==Vector2.RIGHT:
		rot = deg_to_rad(0)
	elif PlayerManager.player.cardinal_direction==Vector2.LEFT:
		rot = deg_to_rad(180)
	var new_arrow = arrow.instantiate()
	new_arrow.position = PlayerManager.player.position
	new_arrow.rotation = rot
	parent.add_child(new_arrow)
