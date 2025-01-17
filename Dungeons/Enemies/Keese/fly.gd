class_name KeeseFly extends EnemyState

@export var after_move_state : EnemyState
@export var min_time : float = 3.0
@export var max_time : float = 6.0

@onready var timer: Timer = $"Change Direction"

var next_state : EnemyState = null

func enter() -> void:
	timer.start(randf_range(min_time,max_time))
	next_state = null
	if enemy.active:
		enemy.animation_player.play("Move")
		enemy.velocity = enemy.current_direction * enemy.speed
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	if enemy.active:
		if enemy.WallDetector.is_colliding():
			#print("Need new Direction")
			enemy.current_direction=enemy.change_direction(enemy.current_direction)
			enemy.velocity = enemy.current_direction * enemy.speed
		if timer.is_stopped():
			timer.stop()
			next_state=after_move_state
		return next_state
	return null
	
func physics( _delta : float ) -> EnemyState:
	return null
