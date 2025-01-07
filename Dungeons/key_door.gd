class_name KeyDoor extends StaticBody2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

@onready var door_mat: DoorMat = $DoorMat
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var direction : SIDE = SIDE.TOP

signal unlocked

var is_opened : bool = false

func _ready() -> void:
	door_mat.unlocked.connect ( unlock_door )

func unlock_door()->void:
	unlocked.emit()
