class_name AquamentusStateWander extends DungeonEnemyState

@export var anim_name : String = "idle"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.7
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : DungeonEnemyState

var _timer : float = 0.0
var _direction : Vector2

func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	if !enemy.active:
		return
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	var rand = randi_range( 0, 1 )
	if rand == 0:
		_direction = enemy.DIR_4[ rand ]
	else:
		_direction = enemy.DIR_4[ 2 ]
	enemy.velocity = _direction * wander_speed
	enemy.SetDirection ( _direction )
	print (_direction)
	enemy.UpdateAnimation( anim_name )
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> DungeonEnemyState:
	if enemy.active:
		_timer -= _delta
		if _timer <= 0:
			return next_state
	return null

func physics( _delta : float ) -> DungeonEnemyState:
	return null
