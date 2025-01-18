class_name TrapReset extends TrapState

@export var after_reset_state : TrapState
@onready var collision_down: RayCast2D = $"../../CollisionDown"
@onready var collision_up: RayCast2D = $"../../CollisionUp"
@onready var collision_left: RayCast2D = $"../../CollisionLeft"
@onready var collision_right: RayCast2D = $"../../CollisionRight"



func enter() -> void:
	enemy.label.text = "RESET"
	if enemy.player_spotted == Vector2.UP:
		enemy.velocity = Vector2(0,30)
		collision_down.enabled=true
	if enemy.player_spotted == Vector2.RIGHT:
		enemy.velocity = Vector2(-30, 0)
		collision_left.enabled=true
	if enemy.player_spotted == Vector2.DOWN:
		enemy.velocity = Vector2(0,-30)
		collision_up.enabled=true
	if enemy.player_spotted == Vector2.LEFT:
		enemy.velocity = Vector2(30, 0)
		collision_right.enabled=true

func exit()->void:
	enemy.velocity=Vector2.ZERO
	collision_up.enabled=false
	collision_right.enabled=false
	collision_down.enabled=false
	collision_left.enabled=false
	pass

func process(_delta: float) -> TrapState:
	if collision_up.is_colliding() or collision_down.is_colliding() or collision_left.is_colliding() or collision_right.is_colliding():
		return after_reset_state
	return null
