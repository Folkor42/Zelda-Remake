class_name WallmasterWithdraw extends EnemyState

@export var move_state : EnemyState
@onready var wall_detector: RayCast2D = $"../../WallDetector"

var next_state : EnemyState = null
var waiting : bool = false

func enter() -> void:
	waiting=false
	print ("Withdrawing")
	if enemy.wall == 0:
		enemy.current_direction=Vector2.DOWN
	elif enemy.wall == 1:
		enemy.current_direction=Vector2.UP
	elif enemy.wall == 2:
		enemy.current_direction=Vector2.RIGHT
	elif enemy.wall == 3:
		enemy.current_direction=Vector2.LEFT
	enemy.update_wall_check_direction(enemy.current_direction)
	next_state = null
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	if enemy.active:
		enemy.velocity = enemy.current_direction * enemy.speed
	if wall_detector.is_colliding() and !waiting:
		wait()
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null

func wait() -> void:
	waiting = true
	enemy.velocity=Vector2.ZERO
	print("Withinwall")
	await get_tree().create_timer(1).timeout
	next_state = move_state
	waiting=false
