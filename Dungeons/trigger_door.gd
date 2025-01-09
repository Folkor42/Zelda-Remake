@tool
class_name TriggerDoor extends StaticBody2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

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
	lock_door()
	get_parent().cleared.connect(toggle_door)
	#get_parent().deactivate.connect(toggle_door)
	#trigger.connect (toggle_door)
	
func toggle_door()->void:
	if is_opened:
		lock_door()
		is_opened=false
	else:
		unlock_door()
		is_opened=true
	
func unlock_door()->void:
	sprite_2d.visible=false
	collision_shape_2d.set_deferred("disabled",true)
	audio.play()
	pass

func lock_door()->void:
	sprite_2d.visible=true
	collision_shape_2d.set_deferred("disabled",false)
	audio.play()
	pass
