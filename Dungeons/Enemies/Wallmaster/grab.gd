class_name WallmasterGrab extends EnemyState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var hurt_box: HurtBox = $"../../HurtBox"
@onready var wall_detector: RayCast2D = $"../../WallDetector"
@onready var hit_box: HitBox = $"../../HitBox"

@export var anim_name : String = "stun"
@export_category("AI")
@export var reset_state : EnemyState


var store_z : int = 0
var next_state : EnemyState

func init() -> void:
	hurt_box.hit.connect (grab)
	pass

func enter() -> void:
	hit_box.set_deferred("monitorable",false)
	store_z = PlayerManager.player.z_index
	#var timer = get_tree().create_timer(0.2)
	enemy.animation_player.play( anim_name )
	print ("Pulling into Wall")
	if enemy.wall == 0:
		enemy.current_direction=Vector2.DOWN
	elif enemy.wall == 1:
		enemy.current_direction=Vector2.UP
	elif enemy.wall == 2:
		enemy.current_direction=Vector2.RIGHT
	elif enemy.wall == 3:
		enemy.current_direction=Vector2.LEFT
	enemy.update_wall_check_direction(enemy.current_direction)
	next_state = null
	pass
pass

func process(delta: float) -> EnemyState:
	PlayerManager.player.z_index=0
	PlayerManager.player.global_position=enemy.global_position+Vector2(2,0)
	enemy.velocity = enemy.current_direction * enemy.speed
	if wall_detector.is_colliding():
		pulled()
	return next_state
	
func grab () -> void:
	hurt_box.set_deferred("monitoring",false)
	state_machine.ChangeState( self )

func pulled()->void:
	# Warp Player back to Start
	var start = get_tree().current_scene.get_child(0)
	PlayerManager.player.global_position=start.global_position
	next_state = reset_state
	pass
	
func exit() -> void:
	PlayerManager.player.z_index=store_z
	hurt_box.set_deferred("monitoring",true)
	hit_box.set_deferred("monitorable",true)
