class_name WallmasterStun extends EnemyState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export_category("AI")
@export var next_state : EnemyState

var timer : float = 3.0
var timestopped : bool = false

func init() -> void:
	enemy.Enemy_Stunned.connect ( _on_enemy_stunned )
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
	pass

func process(delta: float) -> EnemyState:
	timer -= delta
	if timer <0:
		animation_player.play("move")
		return next_state
	return null
	
func exit() -> void:
	timestopped=false
	timer=3.0

func _on_enemy_stunned ( _hurt_box : HurtBox ) -> void:
	state_machine.ChangeState( self )
	pass
