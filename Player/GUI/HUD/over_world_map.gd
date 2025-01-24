extends GridContainer

func _ready() -> void:
	Events.map_cords.connect(_update)
	Events.map_cords_left.connect(reset_block)
	
func _update(x : int, y: int)->void:
	# Changes block to Transparent
	var block = get_node("ColorRect" + str(x+(y-1)*16))
	block.modulate=Color(2, 2, 2, 1)
	
	
func reset_block(x : int, y: int) -> void:
	var reset_block = get_node("ColorRect" + str(x+(y-1)*16))
	reset_block.modulate=Color(1, 1, 1, 1)
