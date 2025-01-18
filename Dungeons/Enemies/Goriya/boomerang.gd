class_name GoriyaBoomerang extends Area2D

enum State { INACTIVE, THROW, RETURN }

var player : Player
var direction : Vector2
var speed : float = 0
var state
var enemy 

@export var acceleration : float = 600.0
@export var max_speed : float  = 300.0
@export var catch_audio : AudioStream

var travelled_distance : float = 0

const RANGE = 176
const SPEED = 150

@onready var hurt_box: HurtBox = $HurtBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(destroy)
	hurt_box.hit.connect(destroy)
	enemy=global_position
	throw( direction )
	pass
	
#func _process(delta: float) -> void:
	#position += transform.x * SPEED * delta
	#travelled_distance += SPEED * delta
	#if travelled_distance > RANGE:
		#queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if state == State.THROW:
		speed -= acceleration * delta
		position += direction * speed * delta
		if speed <= 0:
			state = State.RETURN
		pass
	elif state == State.RETURN:
		direction = global_position.direction_to( enemy )
		speed += acceleration * delta
		position += direction * speed * delta
		if global_position.distance_to( enemy ) <=10:
			#PlayerManager.play_audio( catch_audio )
			queue_free()
		pass
	var speed_ratio : float = speed / max_speed
	#audio.pitch_scale = speed_ratio * 0.75 + 0.75
	animation_player.speed_scale = 1 + ( speed_ratio * 0.25 )
	pass

func throw( throw_direction : Vector2 ) -> void:
	direction = throw_direction
	speed = max_speed
	state = State.THROW
	#animation_player.play("boomerang")
	#PlayerManager.play_audio( catch_audio )
	visible = true
	pass

func _on_area_entered(_area):
	print("HIT SHIELD")
	PlayerManager.player.shield_block_sound.play()
	queue_free()

func destroy(_a = null)->void:
	queue_free()
