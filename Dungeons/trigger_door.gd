@tool
class_name TriggerDoor extends StaticBody2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var player_detector: Area2D = $"../../Floor/Player Detector"

@export var direction : SIDE = SIDE.TOP :
	set ( _v ):
		direction = _v
		_update_texture()

var is_opened : bool = false

func _update_texture() -> void:
	if sprite_2d != null:
		print ("Orienting Door")
		if direction == SIDE.TOP:
			sprite_2d.region_rect = Rect2(914,11,32,32)
		elif direction == SIDE.BOTTOM:
			sprite_2d.region_rect = Rect2(914,110,32,32)
		elif direction == SIDE.LEFT:
			sprite_2d.region_rect = Rect2(914,44,32,32)
		elif direction == SIDE.RIGHT:
			sprite_2d.region_rect = Rect2(914,77,32,32)

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	player_detector.area_entered.connect (room_entered)
	get_parent().cleared.connect(unlock_door)
	
func room_entered(_b)->void:
	#player_detector.area_entered.disconnect (room_entered)
	if is_opened:
		unlock_door()
	else:
		lock_door()
	
func unlock_door()->void:
	#is_opened=true
	sprite_2d.visible=false
	collision_shape_2d.set_deferred("disabled",true)
	#await get_tree().create_timer(.5).timeout
	if is_inside_tree():
		print("Unlocking Door")
		audio.play()
	pass

func lock_door()->void:
	sprite_2d.visible=true
	collision_shape_2d.set_deferred("disabled",false)
	print("Locking Door")
	audio.play()
	pass
