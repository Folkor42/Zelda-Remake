class_name Leever extends Enemy

@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine

@onready var hit_box: HitBox = $HitBox
@onready var hurt_box: HurtBox = $HurtBox
@onready var stun_box: StunBox = $StunBox

@onready var sprite: Sprite2D = $Sprite2D
const SNES_MONSTERS : Texture = preload("res://Assets/SpriteSheets/SNES - Overworld Enemies.png")
const NES_MONSTERS : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Overworld Enemies.png")

enum STATE {UNDER,RISE,ABOVE,SINK}

var current_condition : STATE = STATE.ABOVE

func _ready() -> void:
	enemy_state_machine.initialize( self )
	hit_box.Damaged.connect(enemy_damaged)
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_MONSTERS
	else:
		sprite.texture=NES_MONSTERS


func change_conditions (new_state : String) -> void:
	if new_state=="UNDER":
		current_condition=STATE.UNDER
	elif new_state=="RISE":
		current_condition=STATE.RISE
	elif new_state=="ABOVE":
		current_condition=STATE.ABOVE
	elif new_state=="SINK":
		current_condition=STATE.SINK
	if current_condition==STATE.UNDER:
		hit_box.set_deferred("monitorable", false)
		hurt_box.set_deferred("monitoring", false)
		stun_box.set_deferred("monitorable", false)
	elif current_condition==STATE.RISE or current_condition==STATE.SINK:
		hit_box.set_deferred("monitorable", true)
		hurt_box.set_deferred("monitoring", false)
		stun_box.set_deferred("monitorable", true)
	elif current_condition==STATE.ABOVE:
		hit_box.set_deferred("monitorable", true)
		hurt_box.set_deferred("monitoring", true)
		stun_box.set_deferred("monitorable", true)
	pass
