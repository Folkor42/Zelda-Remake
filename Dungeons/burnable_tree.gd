class_name BurnableTree extends StaticBody2D

@onready var bomb_area: HitBox = $BombArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var opened: PersistantDataHandler = $PersistantDataHandler
@onready var snes_sprite: Sprite2D = $"SNES Sprite"

@export var snes_grass : bool = true

var is_opened : bool = false

func _ready() -> void:
	if snes_grass:
		snes_sprite.texture.region=Rect2(80, 0, 16, 16)
	else:
		snes_sprite.texture.region=Rect2(0, 112, 16, 16)
	opened.data_loaded.connect( set_state )
	bomb_area.Damaged.connect ( unlock_door )
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)

func unlock_door(_b)->void:
	print ("BOOM!")
	opened.set_value()	
	Events.secret_found()
	queue_free()

func set_state () -> void:
	if opened.value:
		queue_free()

func toggle_graphics( _value : bool )->void:
	sprite_2d.visible=!_value
	snes_sprite.visible=_value
