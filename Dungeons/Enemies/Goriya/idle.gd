class_name GoriyaIdle extends EnemyState

@export var delay : float = 0.5
@export var after_idle_state : EnemyState
@export var attack_state : EnemyState

var next_state : EnemyState = null
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	next_state = null
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	if enemy.current_direction==Vector2.LEFT:
		animation_player.play("Move_Left")
	elif enemy.current_direction==Vector2.RIGHT:
		animation_player.play("Move_Right")
	elif enemy.current_direction==Vector2.UP:
		animation_player.play("Move_Up")
	else:
		animation_player.play("Move_Down")
	await get_tree().create_timer(delay).timeout
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
