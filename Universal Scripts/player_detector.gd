extends Area2D

@export var x : int = 0
@export var y : int = 0

func _ready() -> void:
	body_entered.connect (_on_player_detector_body_entered)
	pass # Replace with function body.
	
func _on_player_detector_body_entered(_b) -> void:
	Events.dungeon_map_cords.emit(x,y)
	body_entered.disconnect (_on_player_detector_body_entered)
