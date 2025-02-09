extends Node2D

@onready var wave1: AnimationPlayer = $Wave1/AnimationPlayer
@onready var wave2: AnimationPlayer = $Wave2/AnimationPlayer
@onready var wave3: AnimationPlayer = $Wave3/AnimationPlayer

func _ready() -> void:
	wave1.seek(0)
	wave2.seek(0.2)
	wave3.seek(0.4)
	PlayerHud.visible=false
	PlayerManager.player.visible=false
	flash_triforce()

func flash_triforce ( ) -> void:
	var tween = get_tree().create_tween().chain()
	tween.tween_method(SetShader_BlinkIntensity,0.0,1.0,1.0)
	tween.tween_method(SetShader_BlinkIntensity,1.0,0.0,1.0)
	await tween.finished
	flash_triforce()

func SetShader_BlinkIntensity( newvalue : float) -> void:
	$Sprite2D.material.set_shader_parameter("blink_intensity", newvalue)	
	pass		
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		LevelManager.load_new_level("res://Scenes/file_select.tscn","",Vector2.ZERO)
