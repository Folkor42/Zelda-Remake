class_name Enemy extends CharacterBody2D

enum direction {UP,RIGHT,DOWN,LEFT}
@export var hp : int = 1
@export var speed : float = 50.0
@export_enum ("A", "B", "C", "D", "X") var drop_group
@export var WallDetector : RayCast2D
@export var timer : Timer

var current_direction : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func update_wall_check_direction(new_direction : Vector2)->void:
	if new_direction == Vector2.RIGHT:
		WallDetector.rotation_degrees=-90
	elif new_direction == Vector2.UP:
		WallDetector.rotation_degrees=180
	elif new_direction == Vector2.LEFT:
		WallDetector.rotation_degrees=90
	else:
		WallDetector.rotation_degrees=0
	pass

func validate_new_direction(_d : int )->bool:
	if _d == 1:
		WallDetector.rotation_degrees=270
		if WallDetector.is_colliding():
			return false
	elif _d == 0:
		WallDetector.rotation_degrees=180
		if WallDetector.is_colliding():
			return false
	elif _d == 3:
		WallDetector.rotation_degrees=90
		if WallDetector.is_colliding():
			return false
	else:
		WallDetector.rotation_degrees=0
		if WallDetector.is_colliding():
			return false
	return true
	
func change_direction (old_direction : Vector2) -> Vector2:
	velocity=Vector2.ZERO
	var new : int = randi_range(0,3)
	validate_new_direction(new)
	var new_dir : Vector2
	match new:
		0 : new_dir = Vector2.UP
		1 : new_dir = Vector2.RIGHT
		2 : new_dir = Vector2.DOWN
		3 : new_dir = Vector2.LEFT
	if new_dir == old_direction:
		new_dir=change_direction(old_direction)
	#print (new_dir)
	return new_dir
