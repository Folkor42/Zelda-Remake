extends Sprite2D

@export var triforce_piece : String = "Triforce_"

func _ready() -> void:
	if PlayerManager.inventory.contents.has(triforce_piece):
		visible=true
	else:
		visible=false
