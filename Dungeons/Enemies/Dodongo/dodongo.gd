class_name Dodongo extends Enemy

@onready var hit_box: HitBox = $HitBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var bomb_detector: RayCast2D = $BombDetector

@onready var sprite: Sprite2D = $Sprite2D
const SNES_BOSSES : Texture = preload("res://Assets/SpriteSheets/SNES - Bosses.png")
const NES_BOSSES : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Bosses.png")

var active : bool = true
var bombs_eaten : int = 0

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
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
	activate ()
	
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

func change_direction (old_direction : Vector2) -> Vector2:
	velocity=Vector2.ZERO
	var new : int = randi_range(0,3)
	validate_new_direction(new)
	var new_dir : Vector2
	match new:
		0 : new_dir = Vector2.UP
		1 : new_dir = Vector2.RIGHT
		2 : new_dir = Vector2.DOWN
		3 : new_dir = Vector2.LEFT
	if new_dir == old_direction:
		new_dir=change_direction(old_direction)
	bomb_detector.rotation_degrees=WallDetector.rotation_degrees
	#print (new_dir)
	return new_dir

func _take_damage ( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	PlayerManager.shake_camera()
	if hp > 0:
		return
	else:
		Enemy_Destroyed.emit( hurt_box )
