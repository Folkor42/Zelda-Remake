extends Sprite2D

const NES_HUD : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Link-2.png")
const SNES_HUD : Texture = preload("res://Assets/SpriteSheets/SNES - Link.png")

func _ready() -> void:
	toggle_graphics(PlayerManager.upgraded_graphics)
	Events.toggle_graphics.connect(toggle_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		texture=SNES_HUD
	else:
		texture=NES_HUD
