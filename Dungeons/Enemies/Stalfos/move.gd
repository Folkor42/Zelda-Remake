class_name StalfosMove extends EnemyState

@export var after_move_state : EnemyState
@onready var timer: Timer = $"Change Direction"

var next_state : EnemyState = null

func enter() -> void:
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	next_state = null
	if enemy.active:
		enemy.velocity = enemy.current_direction * enemy.speed
	timer.start()
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	if enemy.active and (enemy.WallDetector.is_colliding() or timer.is_stopped()):
		timer.stop()
		#print("Need new Direction")
		enemy.current_direction=enemy.change_direction(enemy.current_direction)
		enemy.velocity = enemy.current_direction * enemy.speed
		timer.start(3)
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
