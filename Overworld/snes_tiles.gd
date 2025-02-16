extends TileMapLayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_graphics"):
		toggle_graphics()
		
func toggle_graphics()->void:
	enabled=!enabled	
