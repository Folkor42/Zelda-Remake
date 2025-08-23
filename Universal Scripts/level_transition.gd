@tool
class_name LevelTransition extends Area2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

@export_file( "*.tscn" ) var level
@export var target_transition_area : String
@export var center_player : bool = false
@onready var exit: Marker2D = $Exit

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
	#ResourceLoader.load_threaded_request(level)
	pass

func _player_entered ( _p : Node2D ) -> void:
	print ("Load new Scene!")
	LevelManager.load_new_level( level, target_transition_area, Vector2.ZERO )
	SaveManager.save_game()
	pass

func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	
	#PlayerManager.player.cardinal_direction = Vector2.UP
	PlayerManager.set_player_position( exit.global_position )

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
	#print(offset)
	return offset
	
func _update_area() -> void:
	var new_rect : Vector2 = Vector2( 16,16 )
	var new_position : Vector2 = Vector2.ZERO
	var new_exit_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP:
		new_position.y -=8
		new_exit_position=Vector2(0,8)
	elif side == SIDE.BOTTOM:
		new_position.y +=8
		new_exit_position=Vector2(0,-10)
	elif side == SIDE.LEFT:
		new_position.x -=8
		new_exit_position=Vector2(8,0)
	elif side == SIDE.RIGHT:
		new_position.x +=8
		new_exit_position=Vector2(-8,0)
	#if collision_shape_2d == null:
		#collision_shape_2d = get_node("CollisionShape2D")
	if collision_shape_2d != null:	
		collision_shape_2d.shape.size = new_rect
		collision_shape_2d.position = new_position
	if exit != null:
		exit.position=new_exit_position	
		#print(exit.position)
	
func _snap_to_grid () -> void:
	position.x=round( position.x/16 ) * 16
	position.y=round( position.y/16 ) * 16
	
