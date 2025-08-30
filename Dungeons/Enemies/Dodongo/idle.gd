class_name DodongoIdle extends EnemyState

@export var after_idle_state : EnemyState
var next_state : EnemyState = null

func enter() -> void:
	next_state=null
	
	if enemy.active:
		enemy.velocity = Vector2.ZERO
		enemy.current_direction=enemy.change_direction(enemy.current_direction)
	next_state = after_idle_state

func process( _delta : float ) -> EnemyState:
	return next_state

func exit() -> void:
	pass
	
