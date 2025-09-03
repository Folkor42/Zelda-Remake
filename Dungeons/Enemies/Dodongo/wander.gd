class_name DodongoWander extends EnemyState

@export var after_move_state : EnemyState
@onready var timer: Timer = $"Change Direction"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var bomb_detector: RayCast2D = $"../../BombDetector"
@onready var eat: DodongoEat = $"../Eat"

var next_state : EnemyState = null

func enter() -> void:
	timer.start()
	next_state = null
	if enemy.active:
		if enemy.current_direction==Vector2.LEFT:
			animation_player.play("move_left")
		elif enemy.current_direction==Vector2.RIGHT:
			animation_player.play("move_side")
		elif enemy.current_direction==Vector2.UP:
			animation_player.play("move_up")
		else:
			animation_player.play("move_down")
		enemy.velocity = enemy.current_direction * enemy.speed
		#update_wall_check_direction(enemy.current_direction)
	#print (enemy.velocity)
	pass
	
func exit() -> void:
	pass

func process( _delta: float) -> EnemyState:
	if bomb_detector.is_colliding():
		next_state=eat
		return next_state
	if enemy.active and (enemy.WallDetector.is_colliding() or timer.is_stopped()):
		timer.stop()
		#print("Need new Direction")
		next_state=after_move_state
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null
