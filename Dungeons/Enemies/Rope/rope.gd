class_name Rope extends Enemy

@onready var hit_box: HitBox = $HitBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var stun_box: StunBox = $StunBox

@export var throw_swords : bool = false

@onready var sprite: Sprite2D = $Sprite2D
const SNES_MONSTERS : Texture = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")
const NES_MONSTERS : Texture = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")

var active : bool = false
