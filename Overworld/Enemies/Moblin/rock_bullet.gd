class_name RockBullet extends Area2D

var direction
var vertical
var travelled_distance : float = 0

const RANGE = 120
const SPEED = 200

@onready var hurt_box: HurtBox = $HurtBox

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(destroy)
	hurt_box.hit.connect(destroy)
	pass
	
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
	
func _on_area_entered(_area):
	print("HIT SHIELD")
	PlayerManager.player.shield_block_sound.play()
	queue_free()

func destroy(_a = null)->void:
	queue_free()
