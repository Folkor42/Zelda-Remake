class_name OctorokIdle extends EnemyState

@export var anim_name : String = "idle"
@export_category("AI")
@export var state_duration_min : float = 0.4
@export var state_duration_max : float = 1.5
@export var after_idle_state : EnemyState
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

var _timer : float = 0.0

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range ( state_duration_min, state_duration_max )
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	if enemy.current_direction==Vector2.RIGHT:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	if enemy.current_direction==Vector2.UP:
		sprite_2d.flip_v = true
	else:
		sprite_2d.flip_v = false
	enemy.UpdateAnimation( anim_name )
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null

func physics( _delta : float ) -> EnemyState:
	return null
