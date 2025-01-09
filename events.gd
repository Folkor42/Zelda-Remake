extends Node

signal room_entered(room)

func ignore_me()->void:
	room_entered.emit(null)
