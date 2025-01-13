class_name TrapIdle extends TrapState

@export var after_idle_state : TrapState

func enter() -> void:
	enemy.label.text = "IDLE"
	print (enemy.home)
	enemy.velocity = Vector2.ZERO
	if enemy.up:
		enemy.ray_cast_up.enabled=true
	if enemy.right:
		enemy.ray_cast_right.enabled=true
	if enemy.down:
		enemy.ray_cast_down.enabled=true
	if enemy.left:
		enemy.ray_cast_left.enabled=true

func exit() -> void:
	enemy.ray_cast_up.enabled=false
	enemy.ray_cast_down.enabled=false
	enemy.ray_cast_left.enabled=false
	enemy.ray_cast_right.enabled=false
	
func process( _delta : float ) -> TrapState:
	if enemy.ray_cast_up.is_colliding():
		enemy.player_spotted = Vector2.UP
		return after_idle_state
	elif enemy.ray_cast_down.is_colliding():
		enemy.player_spotted = Vector2.DOWN
		return after_idle_state
	elif enemy.ray_cast_left.is_colliding():
		enemy.player_spotted = Vector2.LEFT
		return after_idle_state
	elif enemy.ray_cast_right.is_colliding():
		enemy.player_spotted = Vector2.RIGHT
		return after_idle_state
	return null
