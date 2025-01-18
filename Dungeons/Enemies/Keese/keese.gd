class_name Keese extends Enemy

@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: HitBox = $HitBox

var active : bool = false
var landing : bool = false
var takingoff : bool = false

func _ready() -> void:
	enemy_state_machine.initialize( self )
	hit_box.Damaged.connect(enemy_damaged)
	if get_parent().has_signal("activate"):
		get_parent().activate.connect(activate)
	else:
		get_parent().get_parent().activate.connect(activate)
	if get_parent().has_signal("deactivate"):
		get_parent().deactivate.connect(deactivate)
	else:
		get_parent().get_parent().deactivate.connect(deactivate)

func activate ()->void:
	active = true
	#animation_player.play("Move")
	#var start_time = randf_range(0,0.4)
	#animation_player.seek(start_time,true)
	pass

func deactivate ()->void:
	active = false
	velocity=Vector2.ZERO
	animation_player.play("RESET")
	pass

func enemy_damaged(_hb:HurtBox)->void:
	hp -= _hb.damage
	if hp <= 0:
		Enemy_Destroyed.emit( _hb )
	else:
		Enemy_Damaged.emit( _hb )
		#knockback
		#timer.stop()
		#timer.start(.2)
		#animation_player.play("hit")
		#velocity = -(self.global_position.direction_to(_hb.global_position) * 100)
		#await animation_player.animation_finished
		#animation_player.play("Move")
		pass
