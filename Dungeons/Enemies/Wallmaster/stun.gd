class_name WallmasterStun extends EnemyState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var stun_box: StunBox = $"../../StunBox"

@export_category("AI")
@export var next_state : EnemyState

var timer : float = 3.0
var timestopped : bool = false

func init() -> void:
	enemy.Enemy_Stunned.connect ( _on_enemy_stunned )
	stun_box.Stunned.connect( _on_enemy_stunned )
	Events.stop_time.connect( timestop )

func timestop()->void:
	timestopped = true
	state_machine.ChangeState( self )
		
func enter() -> void:
	# Stunned
	if timestopped:
		timer=20.0
	animation_player.play("stun")
	enemy.velocity = Vector2.ZERO
	await get_tree().create_timer(timer).timeout
	animation_player.play("move")
	state_machine.ChangeState( next_state )
pass

func exit() -> void:
	timestopped=false
	timer=3.0
	
func _on_enemy_stunned ( _hurt_box : HurtBox = null ) -> void:
	state_machine.ChangeState( self )
	pass
