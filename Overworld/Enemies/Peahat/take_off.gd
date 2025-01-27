class_name PeahatTakeOff extends EnemyState

@export var after_move_state : EnemyState
@onready var timer: Timer = $"../Fly/Change Direction"

@export var _maxAcceleration : float = 1.00 ## max rate, limit to acceleration
@export var _accelerationRate : float = 0.005 ## this value is added each physics frame
var _movingAccelRate : float = 0.00 ## abstraction layer
var _currentAccelRate : float = 0.00 ## this will hold your "current" value

var next_state : EnemyState = null

func enter() -> void:
	next_state = null
	enemy.current_direction=enemy.change_direction(enemy.current_direction)
	timer.start(1.2)
	enemy.animation_player.play("speed_up")
	enemy.landed=false
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	
	if timer.is_stopped():
		timer.stop()
		#print("Need new Direction")
		next_state=after_move_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	_movingAccelRate = _currentAccelRate + _accelerationRate
	if _movingAccelRate > _maxAcceleration:
		_movingAccelRate = _maxAcceleration
	enemy.velocity += enemy.current_direction * enemy.speed * _movingAccelRate
	return null
