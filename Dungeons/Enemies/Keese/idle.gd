class_name KeeseIdle extends EnemyState

@export var after_idle_state : EnemyState

var next_state : EnemyState = null


func enter() -> void:
	enemy.animation_player.play("idle")
	next_state = null
	await get_tree().create_timer(1).timeout
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	next_state = after_idle_state
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	return next_state

func physics( _delta : float ) -> EnemyState:
	enemy.velocity = Vector2.ZERO
	return null
