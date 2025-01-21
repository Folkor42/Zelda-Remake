class_name OctorokStun extends EnemyState


@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var stun_box: StunBox = $"../../StunBox"

@export var anim_name : String = "stun"
@export_category("AI")
@export var next_state : EnemyState

var timer : float = 3.0
var timestopped : bool = false

func init() -> void:
	enemy.Enemy_Stunned.connect ( _on_enemy_stunned )
	stun_box.Stunned.connect( _on_enemy_stunned )

func timestop()->void:
	timestopped = true
	state_machine.ChangeState( self )
		
func enter() -> void:
	# Stunned
	timer=3.0
	if timestopped:
		timer=20.0
	enemy.UpdateAnimation( anim_name )
	enemy.velocity = Vector2.ZERO
	await get_tree().create_timer(timer).timeout
	enemy.UpdateAnimation( "idle" )
	state_machine.ChangeState( next_state )
pass

func exit() -> void:
	timestopped=false
	
func _on_enemy_stunned ( _hurt_box : HurtBox = null ) -> void:
	timer=3.0
	state_machine.ChangeState( self )
	pass
