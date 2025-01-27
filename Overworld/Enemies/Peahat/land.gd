class_name PeahatLand extends EnemyState

@export var after_move_state : EnemyState
@onready var timer: Timer = $"../Fly/Change Direction"

@export var _startDeceleration : float = 1.00 ## max rate, limit to acceleration
@export var _decelerationRate : float = 0.1 ## this value is added each physics frame
var _movingDecelRate : float = 0.00 ## abstraction layer
var _currentDecelRate : float = 0.00 ## this will hold your "current" value

var next_state : EnemyState = null

func enter() -> void:
	next_state = null
	_currentDecelRate = _startDeceleration
	timer.start(1.2)
	enemy.animation_player.play("slow_down")
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	if timer.is_stopped():
		timer.stop()
		enemy.landed=true
		next_state=after_move_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	_movingDecelRate = _currentDecelRate - _decelerationRate
	if _movingDecelRate < 0:
		_movingDecelRate = 0
	enemy.velocity = enemy.current_direction * enemy.speed * _movingDecelRate
	return null
