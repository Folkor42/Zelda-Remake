class_name RopeMove extends EnemyState

@export var after_move_state : EnemyState
@onready var timer: Timer = $"Change Direction"
@onready var player_detector_up: RayCast2D = $"../../PlayerDetectorUp"
@onready var player_detector_right: RayCast2D = $"../../PlayerDetectorRight"
@onready var player_detector_left: RayCast2D = $"../../PlayerDetectorLeft"
@onready var player_detector_down: RayCast2D = $"../../PlayerDetectorDown"


@onready var charge: Node = $"../Charge"

var next_state : EnemyState = null

func enter() -> void:
	timer.start()
	next_state = null
	if enemy.current_direction.x < 0:
		enemy.facing_left = true
	elif enemy.current_direction.x > 0:
		enemy.facing_left = false
	if enemy.active:
		enemy.velocity = enemy.current_direction * enemy.speed
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	if enemy.active and (enemy.WallDetector.is_colliding() or timer.is_stopped()):
		timer.stop()
		#print("Need new Direction")
		next_state=after_move_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	if player_detector_down.is_colliding():
		if player_detector_down.get_collider() is Player:
			enemy.update_wall_check_direction(Vector2.DOWN)
			enemy.current_direction=Vector2.DOWN
			print ("Player DOWN")
			return charge
	if player_detector_up.is_colliding():
		enemy.update_wall_check_direction(Vector2.UP)
		enemy.current_direction=Vector2.UP
		print ("Player UP")
		return charge
	if player_detector_right.is_colliding():
		enemy.update_wall_check_direction(Vector2.RIGHT)
		enemy.current_direction=Vector2.RIGHT
		print ("Player RIGHT")
		return charge
	if player_detector_left.is_colliding():
		enemy.update_wall_check_direction(Vector2.LEFT)
		enemy.current_direction=Vector2.LEFT
		print ("Player LEFT")
		return charge
	return null
