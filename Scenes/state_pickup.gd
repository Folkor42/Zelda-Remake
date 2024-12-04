class_name StatePickup extends State

@onready var idle: State_Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var next_state : State = null

func init () -> void:
	player.player_pickup.connect( picked_up )
	pass

func Enter() -> void:
	print ("PICKING UP STATE")
	animation_player.play("pickup")
	await animation_player.animation_finished
	next_state = idle
	pass
	
func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return next_state
		
func Exit() -> void:
		
	pass

func picked_up()->void:
	state_machine.ChangeState( self )
	pass
	
