class_name GoriyaStun extends EnemyState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export_category("AI")
@export var next_state : EnemyState

#func _ready() -> void:
	#enemy.Enemy_Stunned.connect ( _on_enemy_stunned )

func enter() -> void:
	# Stunned
	animation_player.play("Stun")
	enemy.velocity = Vector2.ZERO
	await animation_player.animation_finished
	animation_player.play("Move")
	state_machine.ChangeState( next_state )
pass
	
func _on_enemy_stunned ( _hurt_box : HurtBox ) -> void:
	state_machine.ChangeState( self )
	pass
