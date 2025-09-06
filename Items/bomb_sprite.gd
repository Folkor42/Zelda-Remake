extends Sprite2D

const NES_HUD : Texture = preload("res://Assets/SpriteSheets/NES - Items & Weapons.png")
const SNES_HUD : Texture = preload("res://Assets/SpriteSheets/SNES - Items & Weapons.png")

func _ready() -> void:
	toggle_graphics(PlayerManager.upgraded_graphics)
	Events.toggle_graphics.connect(toggle_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		texture=SNES_HUD
	else:
		texture=NES_HUD
