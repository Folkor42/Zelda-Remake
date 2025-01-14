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

var home : Vector2
var player_spotted : Vector2

func _ready():
	enemy_state_machine.initialize( self )
	home = global_position
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
