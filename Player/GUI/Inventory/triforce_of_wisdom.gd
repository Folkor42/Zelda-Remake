extends Sprite2D

func _ready() -> void:
	if PlayerManager.inventory.contents.has("Triforce"):
		visible=true
	else:
		visible=false
