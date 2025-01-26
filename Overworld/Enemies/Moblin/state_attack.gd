class_name MoblinShoot extends EnemyState

const ENEMYBULLET = preload("res://Overworld/Enemies/Moblin/Moblin Spear.tscn")

@export var anim_name : String = "attack"
@export var after_idle_state : EnemyState
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
#@onready var shoot_audio: AudioStreamPlayer2D = $"../../ShootAudio"

@onready var parent : Node = get_parent().get_parent().get_parent()

var shooting : bool = false
var count : int = 0
var shot_count = 1
func enter() -> void:
	#print("Enemy Shooting")
	enemy.velocity=Vector2.ZERO
	shooting = true
	count = 1
	enemy.UpdateAnimation( anim_name )
	animation_player.animation_finished.connect(stop_shooting)
	pass

func stop_shooting( _a )->void:
	shoot()
	if count < shot_count:
		shooting = true
		count+=1
	else:
		animation_player.animation_finished.disconnect(stop_shooting)
		shooting = false
	pass
	
func exit() -> void:
	if animation_player.animation_finished.is_connected(stop_shooting):
		animation_player.animation_finished.disconnect(stop_shooting)
	pass
	
func process( _delta : float ) -> EnemyState:
	if !shooting:
		return after_idle_state
	else:
		if animation_player.animation_finished:
			animation_player.play()
	return null

func physics( _delta : float ) -> EnemyState:
	return null

func shoot()->void:
	#print("SHOOT towards: "+str(enemy.direction))
	#shoot_audio.play()
	var pos = enemy.global_position
	var rot = enemy.rotation
	if enemy.current_direction==Vector2.UP:
		rot = deg_to_rad(270)
	elif enemy.current_direction==Vector2.DOWN:
		rot = deg_to_rad(90)
	elif enemy.current_direction==Vector2.RIGHT:
		rot = deg_to_rad(0)
	elif enemy.current_direction==Vector2.LEFT:
		rot = deg_to_rad(180)
	_on_enemy_shoot( pos, rot)
	pass
	
func _on_enemy_shoot( pos,rot):
	var bullet = ENEMYBULLET.instantiate()
	bullet.position = pos
	bullet.rotation = rot
	bullet.damage=enemy.hurt_box.damage
	parent.add_child (bullet)
	pass
