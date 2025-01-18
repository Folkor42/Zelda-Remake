class_name GelMove extends EnemyState

@export var after_move_state : EnemyState
@onready var timer: Timer = $Timer

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

func process( _delta : float ) -> EnemyState:
	if timer.is_stopped():
		next_state=after_move_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
