class_name TektiteIdle extends EnemyState

@export var anim_name : String = "idle"
@export_category("AI")
@export var state_duration_min : float = 0.0
@export var state_duration_max : float = 0.1
@export var after_idle_state : EnemyState
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

var _timer : float = 0.0



func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range ( state_duration_min, state_duration_max )
	enemy.current_direction=change_direction(enemy.current_direction)
	enemy.animation_player.play( anim_name )
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

func change_direction (old_direction : Vector2) -> Vector2:
	var new : int = randi_range(0,5)
	var new_dir : Vector2
	match new:
		0 : new_dir = Vector2(-1,1)#DOWNLEFT
		1 : new_dir = Vector2(-1,0)#LEFT
		2 : new_dir = Vector2(-1,-1)#UPLEFT
		3 : new_dir = Vector2(1,1)#DOWNRIGHT
		4 : new_dir = Vector2(1,0)#RIGHT
		5 : new_dir = Vector2(1,-1)#RIGHT
	#print (new_dir)
	new_dir=new_dir.normalized()
	return new_dir
