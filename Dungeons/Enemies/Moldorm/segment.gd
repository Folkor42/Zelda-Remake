extends Node2D

const NES_SPRITE = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")
const SNES_SPRITE = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")

@export var follow_target: Node2D
@export var follow_distance: float = 10.0
@export var follow_speed: float = 100.0

@onready var hit_box: HitBox = $HitBox
@onready var sprite: Sprite2D = $Sprite2D

signal Damaged(dmg : HurtBox)

func _ready() -> void:
	hit_box.Damaged.connect( _on_hit )
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)

func _process(delta):
	if follow_target == null:
		print("No follow")
		return

	var to_target = follow_target.global_position - global_position
	var dist = to_target.length()

	if dist > follow_distance:
		var move_amount = to_target.normalized() * follow_speed * delta
		global_position += move_amount

func _on_hit( _hb : HurtBox ):
	Damaged.emit( _hb )
	
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_SPRITE
	else:
		sprite.texture=NES_SPRITE
