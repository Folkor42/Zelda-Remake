class_name AquamentusStateShoot extends DungeonEnemyState

const ENEMYBULLET = preload("res://Dungeons/Enemies/fireball_bullet.tscn")

@export var anim_name : String = "attack"
@export var after_idle_state : DungeonEnemyState
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
#@onready var shoot_audio: AudioStreamPlayer2D = $"../../ShootAudio"
@onready var mouth: Marker2D = $"../../Mouth"

@onready var parent : Node = get_parent().get_parent().get_parent()

var shooting : bool = false
var count : int = 0
var shot_count = 1
func enter() -> void:
	print("Enemy Shooting")
	enemy.velocity=Vector2.ZERO
	shooting = true
	count = 1
	enemy.UpdateAnimation( anim_name )
	animation_player.animation_finished.connect(stop_shooting)
	shoot()
	pass

func stop_shooting( _a )->void:
	
	if count < shot_count:
		shooting = true
		count+=1
	else:
		animation_player.animation_finished.disconnect(stop_shooting)
		shooting = false
	pass
	
func exit() -> void:
	pass
	
func process( _delta : float ) -> DungeonEnemyState:
	if !shooting:
		return after_idle_state
	else:
		if animation_player.animation_finished:
			animation_player.play()
	return null

func physics( _delta : float ) -> DungeonEnemyState:
	return null

func shoot()->void:
	print("SHOOT towards: "+str(enemy.direction))
	#shoot_audio.play()
	var pos = mouth.global_position
	var dir = (PlayerManager.player.global_position - enemy.global_position).normalized()
	var rot = dir.angle()
	_on_enemy_shoot( pos, rot - deg_to_rad(15))
	_on_enemy_shoot( pos, rot)
	_on_enemy_shoot( pos, rot + deg_to_rad(15))
	pass
	
func _on_enemy_shoot( pos,rot):
	var bullet = ENEMYBULLET.instantiate()
	bullet.position = pos
	bullet.rotation = rot
	parent.add_child (bullet)
	pass
