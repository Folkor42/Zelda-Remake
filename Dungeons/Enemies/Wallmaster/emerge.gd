class_name WallmasterEmerge extends EnemyState

@export var move_state : EnemyState
@onready var wall_detector: RayCast2D = $"../../WallDetector"
@onready var sprite: Sprite2D = $"../../Sprite2D"

var next_state : EnemyState = null
var timer : float

func enter() -> void:
	print ("Emerging")
	timer = 0
	var dir = randi_range (0,1)
	if enemy.wall == 0:
		enemy.current_direction=Vector2.UP
	elif enemy.wall == 1:
		enemy.current_direction=Vector2.DOWN
	elif enemy.wall == 2:
		enemy.current_direction=Vector2.LEFT
	elif enemy.wall == 3:
		enemy.current_direction=Vector2.RIGHT
	if dir == 0:
		sprite.flip_h=false
		if enemy.wall == 0 or enemy.wall == 1:
			enemy.dir = Vector2.RIGHT
		else: enemy.dir = Vector2.DOWN
	else:
		sprite.flip_h=true
		if enemy.wall == 0 or enemy.wall == 1:
			enemy.dir = Vector2.LEFT
		else: 
			enemy.dir = Vector2.UP
	if enemy.wall == 3:
		sprite.flip_h=false
	if enemy.wall == 2:
		sprite.flip_h=true
	enemy.update_wall_check_direction(enemy.current_direction)
	next_state = null
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	if enemy.active:
		enemy.velocity = enemy.current_direction * enemy.speed
		timer += _delta
	if wall_detector.is_colliding() or timer > 2.5:
		next_state = move_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
