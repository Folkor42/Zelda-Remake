extends Sprite2D

const SNES_NPC : Texture = preload("res://Assets/SpriteSheets/SNES - NPCs.png")
const NES_NPC : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - NPCs - 2.png")

func _ready() -> void:
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		texture=SNES_NPC
	else:
		texture=NES_NPC
