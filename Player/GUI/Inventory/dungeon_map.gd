extends Control

@onready var map_pickup_sprite: Sprite2D = $MapPickupSprite
@onready var compass_pickup_sprite: Sprite2D = $CompassPickupSprite
@onready var tile_map_layer: TileMapLayer = $TileMapLayer2

func _ready() -> void:
	if PlayerManager.inventory.contents.has("Map"):
		map_pickup_sprite.visible=true
		tile_map_layer.visible=false
	else: 
		map_pickup_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("Compass"):
		compass_pickup_sprite.visible=true
	else: 
		compass_pickup_sprite.visible=false	
	for x in 8:
		for y in 8:
			if PlayerManager.grid[x][y]==true:
				hide_covering_tile(x,y)

func hide_covering_tile( x : int, y : int ) -> void:
	var tile_position = Vector2i(x,y)
	var source_id = tile_map_layer.get_cell_source_id(tile_position)
	tile_map_layer.set_cell(tile_position, source_id, Vector2i(65, 11), 1)

	# Tried to force an update to ensure changes are rendered
	tile_map_layer.update_internals()
	pass

func _update(x : int, y: int)->void:
	# Changes block to Transparent
	var block = get_node("ColorRect" + str(x+(y-1)*16))
	block.modulate=Color(2, 2, 2, 1)
	
	
func reset_block(x : int, y: int) -> void:
	var reset_block = get_node("ColorRect" + str(x+(y-1)*16))
	reset_block.modulate=Color(1, 1, 1, 1)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Get the global mouse position
		var mouse_position = get_viewport().get_mouse_position()

		# Convert the global mouse position to local position in the TileMapLayer
		var local_position = tile_map_layer.to_local(mouse_position)

		# Convert local position to map coordinates
		var tile_position: Vector2i = tile_map_layer.local_to_map(local_position)

		# Set the tile at the tile_position in the TileMapLayer
		var source_id = tile_map_layer.get_cell_source_id(tile_position)
		print("Tile source ID at position ", tile_position, ": ", source_id)

		tile_map_layer.set_cell(tile_position, source_id, Vector2i(0, 5), 0)

		# Tried to force an update to ensure changes are rendered
		tile_map_layer.update_internals()
