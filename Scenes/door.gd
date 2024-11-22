extends Area2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export_enum("Up", "Right", "Down","Left") var direction: int
# TODO Add Zelda like room Transitons

func _ready() -> void:
	collision_shape_2d.shape.extents = Vector2(8, 4)
	if direction == 0:
		marker_2d.position = Vector2(0,-56)
		collision_shape_2d.rotation_degrees = 0
	if direction == 1:
		marker_2d.position = Vector2(56,0)
		collision_shape_2d.rotation_degrees = 90
		collision_shape_2d.position.x+=4
		collision_shape_2d.position.y+=2
	if direction == 2:
		marker_2d.position = Vector2(0,56)
		collision_shape_2d.rotation_degrees = 180
		collision_shape_2d.position.y+=6
	if direction == 3:
		marker_2d.position = Vector2(-56,0)
		collision_shape_2d.rotation_degrees = -90
		collision_shape_2d.position.x+=-3
		collision_shape_2d.position.y+=2
		
	body_entered.connect(use_door)	
	pass
	
func use_door(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("DOOR")
		body.global_position = marker_2d.global_position
