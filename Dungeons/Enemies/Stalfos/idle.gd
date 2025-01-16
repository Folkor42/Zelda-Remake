class_name StalfosIdle extends EnemyState

@export var after_idle_state : EnemyState
@export var attack_state : EnemyState

var next_state : EnemyState = null


func enter() -> void:
	enemy.velocity = Vector2.ZERO
	next_state = null
	await get_tree().create_timer(0.5).timeout
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	if enemy.throw_swords:
		next_state = attack_state
	else:
		next_state = after_idle_state
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
