class_name RockBullet extends Area2D

var direction
var vertical
var travelled_distance : float = 0

const RANGE = 256
const SPEED = 200

@onready var hurt_box: HurtBox = $HurtBox

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	hurt_box.hit.connect(destroy)
	pass
	
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
	
func _on_area_entered(_area):
	print("HIT")

func destroy()->void:
	queue_free()
