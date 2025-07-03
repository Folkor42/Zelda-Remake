class_name FireballStatue extends Node2D

const NES_SPRITE = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")
const SNES_SPRITE = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")
const ENEMYBULLET = preload("res://Dungeons/Enemies/fireball_bullet.tscn")

@onready var sprite = $Sprite2D
@onready var mouth: Marker2D = $Mouth
@onready var timer: Timer = $Timer

@export var right : bool = false
@export var shoot_speed : float = 3.0

var shooting : bool = false
var player : Player
var invulnerable : bool = true
var active : bool = false

func _ready():
	if right:
		sprite.frame = 1
		mouth.position = Vector2(-3,0)
	else:
		sprite.frame = 0
		mouth.position = Vector2(3,4) 
	timer.wait_time = shoot_speed
	player = PlayerManager.player
	if get_parent().has_signal("activate"):
		get_parent().activate.connect(activate)
	else:
		get_parent().get_parent().activate.connect(activate)
	if get_parent().has_signal("deactivate"):
		get_parent().deactivate.connect(deactivate)
	else:
		get_parent().get_parent().deactivate.connect(deactivate)
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
	timer.timeout.connect(shoot)

func activate ()->void:
	active = true
	timer.wait_time = shoot_speed + randf_range(-0.5,0.5)
	timer.start()
	pass

func deactivate ()->void:
	active = false
	timer.stop()
	pass

func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_SPRITE
	else:
		sprite.texture=NES_SPRITE

func shoot()->void:
	#shoot_audio.play()
	var pos = mouth.global_position
	var dir = (PlayerManager.player.global_position - global_position).normalized()
	var rot = dir.angle()
	_on_enemy_shoot( pos, rot)
	pass
	
func _on_enemy_shoot( pos,rot):
	var bullet = ENEMYBULLET.instantiate()
	bullet.position = pos
	bullet.rotation = rot
	call_deferred("add_child",bullet)
	pass
