extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")
	
func reveal () -> void:
	animation_player.play("reveal")

func cover () -> void:
	animation_player.play("hide")
