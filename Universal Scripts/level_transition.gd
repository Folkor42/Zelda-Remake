@tool
class_name LevelTransition extends Area2D

enum SIDE { TOP, BOTTOM }

@export_file( "*.tscn" ) var level
@export var target_transition_area : String
@export var center_player : bool = false

@export_category("Collision Area Settings")
@export var side: SIDE = SIDE.TOP :
	set ( _v ):
		side = _v
		_update_area()
@export var snap_to_grind : bool = false :
	set ( _v ):
		_snap_to_grid()

@onready var collision_shape_2d: CollisionShape2D

func _ready() -> void:
	collision_shape_2d = $CollisionShape2D
	_update_area()
	if Engine.is_editor_hint():
		return
	monitoring = false
	_place_player()
	
	await LevelManager.level_loaded
	
	monitoring = true
	body_entered.connect( _player_entered )
	
	pass

func _player_entered ( _p : Node2D ) -> void:
	print ("Load new Scene!")
	LevelManager.load_new_level( level, target_transition_area, get_offset() )
	pass

func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	PlayerManager.set_player_position( global_position + LevelManager.position_offset )

func get_offset() -> Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = PlayerManager.player.global_position
	
	if center_player == true:
		offset.x = 0
	else:
		offset.x = player_pos.x - global_position.x
	offset.y = 8
	if side == SIDE.TOP:
		offset.y *= -1
	print(offset)
	return offset
	
func _update_area() -> void:
	var new_rect : Vector2 = Vector2( 16,16 )
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_position.y -=8
	elif side == SIDE.BOTTOM:
		new_position.y +=8
	#if collision_shape_2d == null:
		#collision_shape_2d = get_node("CollisionShape2D")
	if collision_shape_2d != null:	
		collision_shape_2d.shape.size = new_rect
		collision_shape_2d.position = new_position
	
func _snap_to_grid () -> void:
	position.x=round( position.x/16 ) * 16
	position.y=round( position.y/16 ) * 16
	
