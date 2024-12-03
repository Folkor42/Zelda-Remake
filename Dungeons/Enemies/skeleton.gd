class_name Skeleton extends Enemy

const DEATH_ANIM = preload("res://Scenes/enemy_death.tscn")
const PICKUP = preload("res://Items/Item Pickup/item_pickup.tscn")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: HitBox = $HitBox

@export_category("Item Drops")
@export var drops : Array [ DropData ]

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
		drop_items()
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

func drop_items() -> void:
	print("DROPPING ITEMS")
	if drops.size() == 0:
		return
	for i in drops.size():
		if drops[ i ] == null or drops[ i ].item == null:
			continue
		var drop_count : int = drops[ i ].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[ i ].item
			get_parent().set_deferred("add_child", drop )
			drop.global_position = global_position
			drop.velocity = velocity.rotated( randf_range(-1.5, 1.5) ) * randf_range( 0.9, 1.5)
			drop.bounce()
	pass
