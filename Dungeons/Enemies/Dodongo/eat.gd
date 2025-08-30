class_name DodongoEat extends EnemyState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var bomb_detector: RayCast2D = $"../../BombDetector"


@export_category("AI")
@export var next_state : EnemyState

func enter() -> void:
	enemy.bombs_eaten +=1
	var bomb = bomb_detector.get_collider().get_parent()
	bomb.bomb_eat()
	enemy.UpdateAnimation("eat")
	enemy.velocity = Vector2.ZERO
	await animation_player.animation_finished
	if enemy.bombs_eaten >= enemy.hp:
		enemy.Enemy_Destroyed.emit(null)
	state_machine.ChangeState( next_state )
	pass

func exit() -> void:
	pass
