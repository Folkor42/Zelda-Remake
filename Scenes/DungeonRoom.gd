extends Node2D

@onready var player_detector: Area2D = $"Floor/Player Detector"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_detector.body_entered.connect (_on_player_detector_body_entered)
	pass # Replace with function body.


func _on_player_detector_body_entered( _body : Node2D ) -> void:
	if _body is CharacterBody2D:
		Events.room_entered.emit(self)
	pass
