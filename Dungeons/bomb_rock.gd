class_name BombRock extends StaticBody2D

@onready var bomb_area: HitBox = $BombArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var opened: PersistantDataHandler = $PersistantDataHandler

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
