class_name StalfosDamaged extends EnemyState

@onready var timer: Timer = $"../Move/Change Direction"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export_category("AI")
@export var next_state : EnemyState

func init() -> void:
	enemy.Enemy_Damaged.connect( _on_enemy_damaged )
	pass

func enter() -> void:
	#knockback
	timer.stop()
	timer.start(.2)
	animation_player.play("hit")
	enemy.velocity = -(enemy.global_position.direction_to(PlayerManager.player.global_position) * 100)
	await animation_player.animation_finished
	animation_player.play("Move")
	state_machine.ChangeState( next_state )
pass
	
func _on_enemy_damaged ( _hurt_box : HurtBox ) -> void:
	state_machine.ChangeState( self )
	pass
