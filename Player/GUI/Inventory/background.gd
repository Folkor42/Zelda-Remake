extends TextureRect

const NES_HUD : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - HUD & Pause Screen.png")
const SNES_HUD : Texture = preload("res://Assets/SpriteSheets/SNES - HUD & Pause Screen.png")

var atlas_tex: AtlasTexture

func _ready() -> void:
	atlas_tex = texture as AtlasTexture
	assert(atlas_tex != null, "Assign an AtlasTexture to this TextureRect in the Inspector first.")
	toggle_graphics(PlayerManager.upgraded_graphics)
	Events.toggle_graphics.connect(toggle_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	atlas_tex.atlas =  SNES_HUD if _new_value else NES_HUD
	#if _new_value:
		#texture=SNES_HUD
	#else:
		#texture=NES_HUD
