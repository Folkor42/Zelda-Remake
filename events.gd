extends Node

signal room_entered(room)
signal item_used(item)
signal bomb_used()

func _ready() -> void:
	item_used.connect(item_signal)	
	
func ignore_me()->void:
	room_entered.emit(null)
	
func item_signal(item)->void:
	if item == "bomb":
		bomb_used.emit()
