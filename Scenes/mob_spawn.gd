class_name MobSpawner extends Node2D

@export var mob_to_spawn : PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var spawned : bool = false

func _ready() -> void:
	get_parent().body_entered.connect(spawn)
	timer.timeout.connect (reset)
	spawned=false
	
func spawn(_b)->void:
	if !spawned:
		await get_tree().create_timer(randf_range(0.2,1.0))
		animation_player.play("reveal")
		await animation_player.animation_finished
		var mob = mob_to_spawn.instantiate()
		mob.global_position = global_position
		mob.tree_exited.connect(defeated)
		add_child(mob)
		spawned = true
		
		#timer.start()
	else:
		pass
			
func defeated() -> void:
	timer.start()
	
func reset () -> void:
	print ("Resetting")
	spawned=false
	animation_player.play("RESET")
	

# Check to see if the spawners are empty
