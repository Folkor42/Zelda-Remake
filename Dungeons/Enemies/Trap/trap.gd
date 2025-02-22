class_name TrapEnemy extends CharacterBody2D

@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@onready var enemy_state_machine: TrapStateMachine = $EnemyStateMachine
@onready var label: Label = $Label

@export_category("Directions Monitored")
@export var up : bool = false
@export var right : bool = false
@export var down : bool = false
@export var left : bool = false
@export var speed : float = 120

@onready var sprite: Sprite2D = $Sprite2D
const SNES_MONSTERS : Texture = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")
const NES_MONSTERS : Texture = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")

var home : Vector2
var player_spotted : Vector2

func _ready():
	enemy_state_machine.initialize( self )
	home = global_position

	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_MONSTERS
	else:
		sprite.texture=NES_MONSTERS

func _physics_process(_delta: float) -> void:
	move_and_slide()
