class_name TrapAttack extends TrapState

@export var after_attack_state : TrapState
@onready var hurt_box: HurtBox = $"../../HurtBox"

@onready var collision_down: RayCast2D = $"../../CollisionDown"
@onready var collision_up: RayCast2D = $"../../CollisionUp"
@onready var collision_left: RayCast2D = $"../../CollisionLeft"
@onready var collision_right: RayCast2D = $"../../CollisionRight"

var next_state : TrapState = null

func enter() -> void:
	enemy.label.text = "ATTACK"
	next_state=null
	if enemy.player_spotted == Vector2.UP:
		collision_up.enabled=true
		enemy.velocity = Vector2(0,-enemy.speed)
	if enemy.player_spotted == Vector2.RIGHT:
		collision_right.enabled=true
		enemy.velocity = Vector2(enemy.speed, 0)
	if enemy.player_spotted == Vector2.DOWN:
		collision_down.enabled=true
		enemy.velocity = Vector2(0,enemy.speed)
	if enemy.player_spotted == Vector2.LEFT:
		collision_left.enabled=true
		enemy.velocity = Vector2(-enemy.speed, 0)
	hurt_box.hit.connect(hit_player)
	
	
func exit() -> void:
	collision_up.enabled=false
	collision_right.enabled=false
	collision_down.enabled=false
	collision_left.enabled=false
	hurt_box.hit.disconnect(hit_player)
	
func hit_player()->void:
	next_state=after_attack_state	
	
func process(_delta: float) -> TrapState:
	if collision_up.is_colliding() or collision_down.is_colliding() or collision_left.is_colliding() or collision_right.is_colliding():
		return after_attack_state
	return next_state
