class_name MobSpawner extends Node2D

@export var mob_to_spawn : PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var spawned : bool = false

func _ready() -> void:
	await get_tree().physics_frame
	get_parent().body_entered.connect(spawn)
	get_parent().body_exited.connect(clean_up)
	timer.timeout.connect (reset)
	spawned=false

func clean_up(_b) -> void:
	await get_tree().create_timer(5).timeout
	if !get_parent().check_for_player():
		for c in get_children():
			if c is Enemy:
				c.queue_free()
				reset()
	pass

func spawn(_b)->void:
	#print("Spawn")
	if !spawned:
		spawned = true
		await get_tree().create_timer(randf_range(0.2,1.0)).timeout
		animation_player.play("reveal")
		await animation_player.animation_finished
		var mob = mob_to_spawn.instantiate()
		add_child(mob)
		mob.global_position = global_position
		mob.tree_exited.connect(defeated)
	else:
		return
			
func defeated() -> void:
	timer.call_deferred("start")
	
func reset () -> void:
	spawned=false
	animation_player.play("RESET")
	

# Check to see if the spawners are empty
