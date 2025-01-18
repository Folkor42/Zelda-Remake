class_name State_Attack extends State

var attacking : bool = false
const SWORD = preload("res://Player/Sword.tscn")

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/Sword/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var idle: State_Idle = $"../Idle"
@onready var walk: State_Walk = $"../Walk"
@onready var hurt_box: HurtBox = $"../../Sprite2D/Sword/HurtBox"
@onready var sword_cooldown: Timer = $SwordCooldown



func Enter() -> void:
	if PlayerManager.sword=="":
		return
	player.UpdateAnimation("attack")
	attack_animation.play( "attack_" + player.AnimDirection() )
	animation_player.animation_finished.connect ( EndAttack )
	
	if PlayerManager.player.hp == PlayerManager.player.max_hp and sword_cooldown.is_stopped():
		shoot_sword()
		sword_cooldown.start()
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	
	attacking = true
	
	await get_tree().create_timer(0.1).timeout
	if attacking:
		hurt_box.monitoring = true
	pass

func Exit() -> void:
	if animation_player.animation_finished.is_connected( EndAttack ):
		animation_player.animation_finished.disconnect ( EndAttack )
	attacking = false
	hurt_box.monitoring = false
	pass

func Process( _delta : float ) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
func Physics ( _delta : float ) -> State:
	return null
		
func HandleInput ( _event: InputEvent ) -> State:
	return null
	
	
func EndAttack( _newAnimName : String ) -> void:
	#if Input.is_action_pressed("attack"):
		#state_machine.ChangeState( charge_attack )
	attack_animation.stop()
	attacking = false
	pass

func shoot_sword () -> void:
	print ("PEW")
	var bullet = SWORD.instantiate()
	var parent : Node = get_parent().get_parent()
	var rot = deg_to_rad(0)
	if player.cardinal_direction==Vector2.UP:
		rot = deg_to_rad(270)
	elif player.cardinal_direction==Vector2.DOWN:
		rot = deg_to_rad(90)
	elif player.cardinal_direction==Vector2.RIGHT:
		rot = deg_to_rad(0)
	elif player.cardinal_direction==Vector2.LEFT:
		rot = deg_to_rad(180)
	bullet.position = player.position
	bullet.rotation = rot
	parent.add_child (bullet)
	pass
