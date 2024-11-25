class_name State_Stun extends State

@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

var hurt_box : HurtBox
var direction : Vector2

var next_state : State = null

@onready var idle : State = $"../Idle"
@onready var death = $"../Death"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

@export var hurt_sound : AudioStream
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"


func init () -> void:
	player.player_damaged.connect( _player_damaged )
	pass
	
func Enter() -> void:
	
	player.animation_player.animation_finished.connect( _animation_finished )
	direction = player.global_position.direction_to( hurt_box.global_position )
	player.velocity = direction * -knockback_speed
	player.SetDirection()
	player.UpdateAnimation("stun")
	player.make_invulnerable ( invulnerable_duration )
	audio.stream = hurt_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	#player.effect_animation_player.play( "damaged" )
	#PlayerManager.shake_camera( hurt_box.damage )
	next_state = idle
	pass

func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect( _animation_finished )
	pass

func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
func Physics ( _delta : float ) -> State:
	return null
		
func HandleInput ( _event: InputEvent ) -> State:
	return null
	
func _player_damaged ( _hurt_box : HurtBox ) -> void:
	hurt_box = _hurt_box
	if state_machine.current_state!=death:
		state_machine.ChangeState( self )
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity,1.0,0.0,0.5)
	pass

func _animation_finished ( _a : String ) -> void:
	next_state = idle
	if player.hp <= 0:
		next_state=death
	pass

func SetShader_BlinkIntensity( newvalue : float) -> void:
	sprite_2d.material.set_shader_parameter("blink_intensity", newvalue)	
	pass	
