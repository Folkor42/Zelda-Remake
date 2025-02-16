class_name BombRock extends StaticBody2D

@onready var bomb_area: HitBox = $BombArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var opened: PersistantDataHandler = $PersistantDataHandler
@onready var snes_sprite: Sprite2D = $"SNES Sprite"

var is_opened : bool = false

func _ready() -> void:
	opened.data_loaded.connect( set_state )
	bomb_area.Damaged.connect ( unlock_door )

func unlock_door(_b)->void:
	print ("BOOM!")
	opened.set_value()	
	Events.secret_found()
	queue_free()

func set_state () -> void:
	if opened.value:
		queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_graphics"):
		toggle_graphics()
		
func toggle_graphics()->void:
	sprite_2d.visible=!sprite_2d.visible	
	snes_sprite.visible=!snes_sprite.visible	
