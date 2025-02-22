class_name LevelTileMap extends TileMapLayer

func _ready():
	LevelManager.ChangeTileMapBounds( GetTileMapBounds() )
	visible=!PlayerManager.upgraded_graphics
	Events.toggle_graphics.connect(toggle_graphics)
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
	
func toggle_graphics( _new_value : bool )->void:
	visible=!_new_value
