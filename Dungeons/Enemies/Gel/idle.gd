class_name GelIdle extends EnemyState

@export var after_idle_state : EnemyState

var next_state : EnemyState = null

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	next_state = null
	await get_tree().create_timer(0.5).timeout
	next_state = after_idle_state
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
