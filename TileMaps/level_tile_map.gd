class_name LevelTileMap extends TileMapLayer

func _ready():
	LevelManager.ChangeTileMapBounds( GetTileMapBounds() )
	pass
	
func GetTileMapBounds () -> Array [ Vector2 ]:
	var bounds : Array [ Vector2 ] = []
	bounds.append(
		Vector2( get_used_rect().position * rendering_quadrant_size )
	)
	bounds.append(
		Vector2( get_used_rect().end * rendering_quadrant_size )
	)
	return bounds
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_graphics"):
		toggle_graphics()
		
func toggle_graphics()->void:
	visible=!visible	
