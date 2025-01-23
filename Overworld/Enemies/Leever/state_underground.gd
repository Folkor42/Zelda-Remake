class_name LeeverUnderground extends EnemyState

@export var anim_name : String = "idle"
@export_category("AI")
@export var state_duration_min : float = 3.0
@export var state_duration_max : float = 3.0
@export var after_idle_state : EnemyState
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var current_to_target: RayCast2D = $"../../CurrentToTarget"
@onready var target_position: Marker2D = $"../../CurrentToTarget/TargetPosition"
@onready var target_to_player: RayCast2D = $"../../CurrentToTarget/TargetPosition/TargetToPlayer"


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
	var player_distance = enemy.global_position.distance_to(PlayerManager.player.global_position)
	print (player_distance)
	if player_distance > 100:
		print ("Nah, too far!")
	else:
		find_new_location()
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

func find_new_location():
	
	# TODO
	# NOTE 1. Get the player's position and determine the target position in line with the player but at a safe distance.
	move_target()

	# NOTE 2. Check for obstacles between the monster's current position and the target position using raycasts or physics collision checks.
	if current_to_target.is_colliding():
		print("Can't move to new RISE spot safely")
		move_target()

	# NOTE 3. Adjust the position if needed to ensure it is valid and not inside a wall.
	if wall_detector.is_colliding():
		print ("I'm in a wall Dumbass!")
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

func offset_from_player( direction : Vector2 ) -> Vector2:
	# NOTE Offset the rise spot a safe distance from where the palyer was when calculated.
	if direction == Vector2.RIGHT:
		return Vector2(50,0)
	elif direction == Vector2.UP:
		return Vector2(0,-50)
	elif direction == Vector2.LEFT:
		return Vector2(-50,0)
	else:
		return Vector2(0,50)
	pass

func move_target()->void:
	var player_pos = PlayerManager.player.global_position
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	target_position.global_position = player_pos - offset_from_player(enemy.current_direction)
	current_to_target.target_position=target_position.position
	target_to_player.target_position=offset_from_player(enemy.current_direction)
	pass
