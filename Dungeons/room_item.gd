extends Node2D

@onready var player_detector: Area2D = $"Floor/Player Detector"

signal activate
signal deactivate

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player.remove_camera()
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	LevelManager.level_load_started.connect( _free_level )
	#AudioManager.play_music( music )

	player_detector.body_entered.connect (_on_player_detector_body_entered)
	player_detector.body_exited.connect (_on_player_detector_body_exited)

	pass # Replace with function body.


func _on_player_detector_body_entered( _body : Node2D ) -> void:
	if _body is CharacterBody2D:
		Events.room_entered.emit(self)
		activate.emit()
	pass

func _on_player_detector_body_exited( _body : Node2D ) -> void:
	if _body is CharacterBody2D:
		deactivate.emit()
	pass

func _free_level() -> void:
	PlayerManager.unparent_player ( self )
	queue_free()
	pass
