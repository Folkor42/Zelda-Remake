class_name ZoraUnderwater extends EnemyState

@export var wander_speed : float = 20.0
@export var anim_name : String = "move"

@export_category("AI")
@export var state_duration_min : float = 1.0
@export var state_duration_max : float = 3.0
@export var after_idle_state : EnemyState
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var wall_detector: RayCast2D = $"../../WallDetector"

var _timer : float = 0.0

func enter() -> void:
	sprite_2d.visible=false
	_timer = randf_range ( state_duration_min, state_duration_max )
	enemy.velocity = enemy.current_direction * enemy.speed
	enemy.animation_player.play( anim_name )
	pass
	
func exit() -> void:
	sprite_2d.visible=true
	enemy.change_conditions("RISE")
	pass

func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		if wall_detector.is_colliding():
			print ("I've hit the shore!")
			#enter()
			#return null
		return after_idle_state
	return null

func physics( _delta : float ) -> EnemyState:
	return null
