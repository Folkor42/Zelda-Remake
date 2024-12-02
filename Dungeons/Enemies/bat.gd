class_name Bat extends Enemy

const DEATH_ANIM = preload("res://Scenes/enemy_death.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.Damaged.connect(enemy_damaged)
	var start_time = randf_range(0,0.4)
	animation_player.seek(start_time,true)
	
func _process(_delta: float) -> void:
	if WallDetector.is_colliding() or timer.is_stopped():
		timer.stop()
		#print("Need new Direction")
		current_direction=change_direction(current_direction)
		velocity = current_direction * speed
		timer.start(3)

func enemy_damaged(_hb:HurtBox)->void:
	hp -= _hb.damage
	if hp <= 0:
		var death = DEATH_ANIM.instantiate()
		death.position=position
		get_parent().add_child(death)
		queue_free()
	else:
		#knockback
		timer.stop()
		timer.start(.2)
		animation_player.play("hit")
		velocity = -(self.global_position.direction_to(_hb.global_position) * 100)
		await animation_player.animation_finished
		animation_player.play("Move")
		pass
