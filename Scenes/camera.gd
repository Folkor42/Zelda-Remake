extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.room_entered.connect (change_room)
	#global_position=Vector2(-256,0)
	pass # Replace with function body.

func change_room(room)->void:
	global_position=room.global_position
