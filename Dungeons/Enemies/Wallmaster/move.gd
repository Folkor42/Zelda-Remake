class_name WallmasterMove extends EnemyState

@export var after_move_state : EnemyState
@export var min_time : float
@export var max_time : float
@onready var timer: Timer = $Timer

var next_state : EnemyState = null

func enter() -> void:
	var time = randf_range(min_time,max_time)
	enemy.current_direction = enemy.dir	
	next_state = null
	timer.wait_time=time
	timer.start()
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	if enemy.active:
		enemy.velocity = enemy.current_direction * enemy.speed
	if timer.is_stopped():
		next_state=after_move_state
	
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
