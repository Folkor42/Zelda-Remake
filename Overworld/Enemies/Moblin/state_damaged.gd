class_name MoblinDamage extends EnemyState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export var knock_back : float = 100
@export var anim_name : String = "stun"
@export_category("AI")
@export var next_state : EnemyState

func init() -> void:
	enemy.Enemy_Damaged.connect( _on_enemy_damaged )
	pass

func enter() -> void:
	#knockback
	var timer = get_tree().create_timer(0.2)
	enemy.UpdateAnimation( anim_name )
	enemy.velocity = -(enemy.global_position.direction_to(PlayerManager.player.global_position) * knock_back)
	await timer.timeout
	state_machine.ChangeState( next_state )
pass
	
func _on_enemy_damaged ( _hurt_box : HurtBox ) -> void:
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity,1.0,0.0,1.0)
	state_machine.ChangeState( self )

func SetShader_BlinkIntensity( newvalue : float) -> void:
	$"../../Sprite2D".material.set_shader_parameter("blink_intensity", newvalue)	
	pass		
