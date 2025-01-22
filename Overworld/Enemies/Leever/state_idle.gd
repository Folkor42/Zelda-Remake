class_name LeeverIdle extends EnemyState

@export var anim_name : String = "idle"
@export_category("AI")
@export var state_duration_min : float = 1.0
@export var state_duration_max : float = 3.0
@export var after_idle_state : EnemyState
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

var _timer : float = 0.0



func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	sprite_2d.visible=false
	enemy.velocity = Vector2.ZERO
	_timer = randf_range ( state_duration_min, state_duration_max )
	print("Picking new Direction")
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	sprite_2d.scale.x = -1 if enemy.current_direction== Vector2.LEFT else 1
	enemy.animation_player.play( anim_name )
	print (enemy.current_direction)
	pass
	
func exit() -> void:
	sprite_2d.visible=true
	enemy.change_conditions("RISE")
	pass

func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null

func physics( _delta : float ) -> EnemyState:
	return null
