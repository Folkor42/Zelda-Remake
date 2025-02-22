class_name ItemData extends Resource

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D
@export var snes_texture : Texture2D

@export_category("Item Use Effects")
@export var value : int = 0
@export var effects : Array [ ItemEffect ]

@export_category("Item Animation")
@export var animated : bool = false
@export var h_frames : int = 1
@export var v_frames : int = 1
@export var frames : int = 1

func use () -> bool:
	if effects.size() == 0:
		return false
	
	for e in effects:
		if e: 
			e.use()
	return true
