class_name PeahatIdle extends EnemyState

@export var after_idle_state : EnemyState

var next_state : EnemyState = null


func enter() -> void:
	enemy.landed=true
	enemy.animation_player.play("idle")
	next_state = null
	await get_tree().create_timer(2).timeout
	next_state = after_idle_state
	pass
	
func exit() -> void:
	enemy.landed=false
	pass

func process( _delta : float ) -> EnemyState:
	return next_state

func physics( _delta : float ) -> EnemyState:
	enemy.velocity = Vector2.ZERO
	return null
