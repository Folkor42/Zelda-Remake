class_name Moblin extends Enemy

@onready var hit_box: HitBox = $HitBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var hurt_box: HurtBox = $HurtBox

func _ready() -> void:
	enemy_state_machine.initialize( self )
	hit_box.Damaged.connect(enemy_damaged)
