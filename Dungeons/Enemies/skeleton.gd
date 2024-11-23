class_name Skeleton extends Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.Damaged.connect(enemy_damaged)
	var start_time = randf_range(0,0.4)
	animation_player.seek(start_time,true)
	
func _process(_delta: float) -> void:
	if WallDetector.is_colliding() or timer.is_stopped():
		timer.stop()
		print("Need new Direction")
		current_direction=change_direction(current_direction)
		velocity = current_direction * speed
		timer.start(3)

func enemy_damaged(_hb:HurtBox)->void:
	hp -= _hb.damage
	if hp <= 0:
		queue_free()
