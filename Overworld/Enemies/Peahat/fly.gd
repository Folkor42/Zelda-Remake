class_name PeahatFly extends EnemyState

@export var after_move_state : EnemyState
@export var min_time : float = 3.0
@export var max_time : float = 9.0

@onready var change_direction: Timer = $"Change Direction"
@onready var fly_time: Timer = $FlyTime


var next_state : EnemyState = null

func enter() -> void:
	enemy.landed=false
	fly_time.start(randf_range(min_time,max_time))
	change_direction.start(randf_range(2,6))
	next_state = null
	print("Flying")
	enemy.animation_player.play("Move")
	enemy.velocity = enemy.current_direction * enemy.speed
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	enemy.velocity = enemy.current_direction * enemy.speed
	if change_direction.is_stopped():
		enemy.current_direction=enemy.change_direction(enemy.current_direction)
		change_direction.start(randf_range(0,2))
	if fly_time.is_stopped():
		next_state=after_move_state
		return next_state
	return null
	
func physics( _delta : float ) -> EnemyState:
	return null
