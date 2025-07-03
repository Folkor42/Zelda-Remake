class_name Rope extends Enemy

@onready var hit_box: HitBox = $HitBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var stun_box: StunBox = $StunBox

@onready var sprite: Sprite2D = $Sprite2D
const SNES_MONSTERS : Texture = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")
const NES_MONSTERS : Texture = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")

var active : bool = false
var facing_left : bool = false

func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_MONSTERS
	else:
		sprite.texture=NES_MONSTERS

func _ready() -> void:
	var start_time = randf_range(0,0.4)
	animation_player.seek(start_time,true)
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
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)

func activate ()->void:
	active = true
	pass

func deactivate ()->void:
	active = false
	velocity=Vector2.ZERO
	pass

func _process(_delta: float) -> void:
	$Sprite2D.flip_h=facing_left
	if facing_left:
		$PlayerDetectorRight.enabled=false
		$PlayerDetectorLeft.enabled=true
	else:
		$PlayerDetectorRight.enabled=true
		$PlayerDetectorLeft.enabled=false
