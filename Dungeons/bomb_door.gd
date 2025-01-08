class_name BombDoor extends StaticBody2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

@onready var bomb_area: HitBox = $BombArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var direction : SIDE = SIDE.TOP

signal unlocked

var is_opened : bool = false

func _ready() -> void:
	bomb_area.Damaged.connect ( unlock_door )
	if direction == SIDE.TOP:
		sprite_2d.region_rect = Rect2(815,11,32,32)
	elif direction == SIDE.LEFT:
		sprite_2d.region_rect = Rect2(815,44,32,32)
	elif direction == SIDE.RIGHT:
		sprite_2d.region_rect = Rect2(815,77,32,32)
	elif direction == SIDE.BOTTOM:
		sprite_2d.region_rect = Rect2(815,110,32,32)

func unlock_door(_b)->void:
	print ("BOOM!")
	unlocked.emit()
	queue_free()
