class_name DungeonEnemy extends CharacterBody2D

signal Direction_Changed ( new_direction : Vector2 )
signal Enemy_Damaged ( hurt_box : HurtBox )
signal enemy_destroyed ( hurt_box : HurtBox )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false
var active : bool = false

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : DungeonEnemyStateMachine = $EnemyStateMachine

const SNES_BOSSES : Texture = preload("res://Assets/SpriteSheets/SNES - Bosses.png")
const NES_BOSSES : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Bosses.png")


func _ready():
	state_machine.initialize( self )
	player = PlayerManager.player
	hit_box.Damaged.connect( _take_damage )
	cardinal_direction=Vector2.DOWN
	
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
		sprite.texture=SNES_BOSSES
	else:
		sprite.texture=NES_BOSSES


func activate ()->void:
	active = true
	pass

func deactivate ()->void:
	active = false
	velocity=Vector2.ZERO
	pass
	
func _process(_delta):
	pass


func _physics_process(_delta):
	move_and_slide()
	pass
	
func calculate_direction_index( direction_temp : Vector2 , cardinal_direction_temp : Vector2 , dir_size: int ) -> int:
	var direction_bias = 0.1
	var angle = (direction_temp + cardinal_direction_temp * direction_bias).angle()
	var normalized_angle = angle / TAU
	var direction_idx = int(round(normalized_angle * dir_size))
	return direction_idx
	
func SetDirection( _new_direction : Vector2 ) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = calculate_direction_index(direction, cardinal_direction, DIR_4.size())
	var new_dir = DIR_4[ direction_id ]
		
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	Direction_Changed.emit( new_dir )
	#sprite.scale.x = -1 if cardinal_direction== Vector2.LEFT else 1
	return true

func UpdateAnimation( state : String ) -> void:
	animation_player.play( state + "_" + AnimDirection() )
	pass
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
func _take_damage ( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	PlayerManager.shake_camera()
	if hp > 0:
		Enemy_Damaged.emit( hurt_box )
	else:
		enemy_destroyed.emit( hurt_box )
