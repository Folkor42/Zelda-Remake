class_name RopeCharge extends EnemyState

@export var after_charge_state : EnemyState
@export var charge_speed : float = 75.0
@onready var player_detector_down: RayCast2D = $"../../PlayerDetectorDown"
@onready var player_detector_up: RayCast2D = $"../../PlayerDetectorUp"
@onready var player_detector_right: RayCast2D = $"../../PlayerDetectorRight"
@onready var player_detector_left: RayCast2D = $"../../PlayerDetectorLeft"

var next_state : EnemyState = null

func enter() -> void:
	next_state = null
	if enemy.active:
		enemy.velocity = enemy.current_direction * charge_speed
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	if enemy.active and (enemy.WallDetector.is_colliding()): #or !player_detector.is_colliding()
		#print("Need new Direction")
		next_state=after_charge_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
