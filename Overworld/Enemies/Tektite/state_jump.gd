class_name TektiteJump extends EnemyState

@export var anim_name : String = "jump"

@export_category("AI")
@export var after_jump_state : EnemyState

var next_state : EnemyState

func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	next_state=null
	enemy.animation_player.play( anim_name )
	enemy.animation_player.animation_finished.connect ( landed )
	enemy.velocity = enemy.current_direction * enemy.speed
	pass
	
func exit() -> void:
	if enemy.animation_player.animation_finished.is_connected( landed ):
		enemy.animation_player.animation_finished.disconnect ( landed )
	pass

func process( _delta : float ) -> EnemyState:
	return next_state

func landed ( _a ) -> void:
	enemy.animation_player.animation_finished.disconnect ( landed )
	next_state = after_jump_state

func physics( _delta : float ) -> EnemyState:
	return null
