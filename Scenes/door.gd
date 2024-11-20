extends Area2D

@onready var marker_2d: Marker2D = $Marker2D

# TODO Add in a drop down to select the door direction, so we don't have to move the Marker2D everytime.
# TODO Shrink door collision sizes to make transitions feel smoother.
# TODO Add Zelda like room Transitons

func _ready() -> void:
	body_entered.connect(use_door)	
	pass
	
func use_door(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("DOOR")
		body.global_position = marker_2d.global_position
