class_name BombPlanted extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func bomb_eat()->void:
	await get_tree().create_timer(0.1).timeout
	animation_player.stop()
	queue_free()
