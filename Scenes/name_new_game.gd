extends CanvasLayer
@onready var name_new_game: CanvasLayer = $"."
@onready var text_edit: LineEdit = $ColorRect/Control/VBoxContainer/TextEdit
@onready var loading_overlay: CanvasLayer = $"../LoadingOverlay"

@onready var button_create: Button = $ColorRect/Control/VBoxContainer/HBoxContainer/ButtonCreate
@onready var button_cancel: Button = $ColorRect/Control/VBoxContainer/HBoxContainer/ButtonCancel

var filename : String

func _ready() -> void:
	button_cancel.pressed.connect (hide_new_game_screen)
	button_create.pressed.connect (attempt_new_game)

func show_new_game_screen(selected_slot : int) -> void:
	name_new_game.visible=true
	await get_tree().process_frame
	text_edit.grab_focus()
	filename = "user://"+str(selected_slot)+".save"
	
	
func hide_new_game_screen() -> void:
	name_new_game.visible=false
	$"../Control/VBoxContainer/ButtonStart".grab_focus()

func attempt_new_game()->void:
	if create_new_game():
		print("Success")
		loading_overlay.visible=true
		LevelManager.load_new_level("res://Overworld/over_world_quest_1.tscn","",Vector2.ZERO)
	else:
		print("Failed to create new file.")
	
func create_new_game()->bool:
	if FileAccess.file_exists(filename):
		print (filename+" already exists!")
		return false
	var save_file = FileAccess.open(filename, FileAccess.WRITE)
	var initial_save : Dictionary
	initial_save = {"name":text_edit.text,"time_played":0.0}
	save_file.store_line(JSON.stringify(initial_save))
	return true
