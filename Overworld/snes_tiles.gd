extends TileMapLayer

func _ready() -> void:
	enabled=PlayerManager.upgraded_graphics
	Events.toggle_graphics.connect(toggle_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	enabled=_new_value
