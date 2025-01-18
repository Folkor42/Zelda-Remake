class_name MoveableBlock extends Node2D

signal moved

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	print ("Block Moved")
	moved.emit()
