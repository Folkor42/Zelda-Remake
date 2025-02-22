class_name Wallmaster extends Enemy

@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var hit_box: HitBox = $HitBox

enum direction {UP,DOWN,LEFT,RIGHT}
@export var wall: direction

@onready var sprite: Sprite2D = $Sprite2D
const SNES_MONSTERS : Texture = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")
const NES_MONSTERS : Texture = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")

var active = false
var dir : Vector2

func _ready() -> void:
	enemy_state_machine.initialize( self )
	hit_box.Damaged.connect(enemy_damaged)
	#stun_box.Stunned.connect(enemy_stunned)

	if get_parent().has_signal("activate"):
		get_parent().activate.connect(activate)
	else:
		get_parent().get_parent().activate.connect(activate)
	if get_parent().has_signal("deactivate"):
		get_parent().deactivate.connect(deactivate)
	else:
		get_parent().get_parent().deactivate.connect(deactivate)
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_MONSTERS
	else:
		sprite.texture=NES_MONSTERS
		
func activate ()->void:
	active = true
	var start_time = randf_range(0,0.3)
	animation_player.seek(start_time,true)
	pass

func deactivate ()->void:
	active = false
	velocity=Vector2.ZERO
	pass
	
