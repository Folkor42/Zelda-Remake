class_name MoblinSpear extends Area2D

var direction
var vertical
var travelled_distance : float = 0
var damage = 1

const RANGE = 120
const SPEED = 200
const SNES_MONSTERS : Texture = preload("res://Assets/SpriteSheets/SNES - Overworld Enemies.png")
const NES_MONSTERS : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Overworld Enemies.png")

@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(destroy)
	hurt_box.hit.connect(destroy)
	hurt_box.damage=damage
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_MONSTERS
	else:
		sprite.texture=NES_MONSTERS
	
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
	
func _on_area_entered(_area):
	#print("HIT SHIELD")
	PlayerManager.player.shield_block_sound.play()
	queue_free()

func destroy(_a = null)->void:
	queue_free()
