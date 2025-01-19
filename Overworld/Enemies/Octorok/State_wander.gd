class_name OctorokWander extends EnemyState

@export var anim_name : String = "idle"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.7
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0

func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	enemy.UpdateAnimation( anim_name )
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	enemy.velocity = enemy.current_direction * enemy.speed
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null

func physics( _delta : float ) -> EnemyState:
	return null
