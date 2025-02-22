class_name Octorok extends Enemy

@onready var hit_box: HitBox = $HitBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var sprite: Sprite2D = $Sprite2D

const SNES_MONSTERS : Texture = preload("res://Assets/SpriteSheets/SNES - Overworld Enemies.png")
const NES_MONSTERS : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Overworld Enemies.png")

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
