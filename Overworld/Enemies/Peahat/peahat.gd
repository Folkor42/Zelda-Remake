class_name Peahat extends Enemy

@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var hit_box: HitBox = $HitBox

var landed : bool = false


func _ready() -> void:
	enemy_state_machine.initialize( self )
	hit_box.Damaged.connect(enemy_damaged)

func enemy_damaged(_hb:HurtBox)->void:
	if landed:
		hp -= _hb.damage
		if hp <= 0:
			Enemy_Destroyed.emit( _hb )
		else:
			Enemy_Damaged.emit( _hb )
	pass
