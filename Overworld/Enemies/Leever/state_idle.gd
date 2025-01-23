class_name LeeverIdle extends EnemyState

@export var anim_name : String = "idle"
@export_category("AI")
@export var state_duration_min : float = 1.0
@export var state_duration_max : float = 3.0
@export var after_idle_state : EnemyState
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var target_position: Marker2D = $"../../TargetPosition"
@onready var path_to_player: RayCast2D = $"../../TargetPosition/PathToPlayer"

@onready var wall_detector: RayCast2D = $"../../WallDetector"

var _timer : float = 0.0
var underground_speed = 200  # Speed while moving underground
var rise_distance = 200  # Distance away from the player to rise
var collision_mask = 1  # Adjust based on your walls/obstacles layer

func init() -> void:
	pass # Replace with function body.

func enter() -> void:
	sprite_2d.visible=false
	enemy.velocity = Vector2.ZERO
	_timer = randf_range ( state_duration_min, state_duration_max )
	move_underground()
	enemy.animation_player.play( anim_name )
	pass
	
func exit() -> void:
	sprite_2d.visible=true
	enemy.change_conditions("RISE")
	pass

func process( _delta : float ) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		if wall_detector.is_colliding():
			print ("I'm in a wall!")
			return $"../Submerge"
		return after_idle_state
	return null

func physics( _delta : float ) -> EnemyState:
	return null

func move_underground():
	# TODO
	# NOTE 1. Get the player's position and determine the target position in line with the player but at a safe distance.
	move_target()
	# NOTE 2. Check for obstacles between the monster's current position and the target position using raycasts or physics collision checks.
	if path_to_player.is_colliding():
		print("BLOCKED")
		move_target()
	# NOTE 3. Adjust the position if needed to ensure it is valid and not inside a wall.
	if wall_detector.is_colliding():
		move_target()
	# NOTE 4. Move the monster to the target position.
	enemy.global_position=target_position.global_position
	pass

func change_location( new_direction : Vector2 ) -> Vector2:
	if new_direction == Vector2.RIGHT:
		return PlayerManager.player.global_position - Vector2(50,0)
	elif new_direction == Vector2.UP:
		return PlayerManager.player.global_position - Vector2(0,-50)
	elif new_direction == Vector2.LEFT:
		return PlayerManager.player.global_position - Vector2(-50,0)
	else:
		return PlayerManager.player.global_position - Vector2(0,50)

func move_target()->void:
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	target_position.global_position=change_location(enemy.current_direction)
	path_to_player.rotation_degrees=wall_detector.rotation_degrees
	pass
