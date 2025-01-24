class_name Leever extends Enemy

@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine

@onready var hit_box: HitBox = $HitBox
@onready var hurt_box: HurtBox = $HurtBox
@onready var stun_box: StunBox = $StunBox


enum STATE {UNDER,RISE,ABOVE,SINK}

var current_condition : STATE = STATE.ABOVE

func _ready() -> void:
	enemy_state_machine.initialize( self )
	hit_box.Damaged.connect(enemy_damaged)

func change_conditions (new_state : String) -> void:
	if new_state=="UNDER":
		current_condition=STATE.UNDER
	elif new_state=="RISE":
		current_condition=STATE.RISE
	elif new_state=="ABOVE":
		current_condition=STATE.ABOVE
	elif new_state=="SINK":
		current_condition=STATE.SINK
	if current_condition==STATE.UNDER or current_condition == STATE.RISE:
		hit_box.set_deferred("monitorable", false)
		hurt_box.set_deferred("monitoring", false)
		stun_box.set_deferred("monitorable", false)
	else:
		hit_box.set_deferred("monitorable", true)
		hurt_box.set_deferred("monitoring", true)
		stun_box.set_deferred("monitorable", true)
	pass
