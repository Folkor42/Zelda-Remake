extends CanvasLayer
@onready var file_select: CanvasLayer = $".."
@onready var filename: Label = $ColorRect/VBoxContainer/filename
@onready var confirm: Button = $ColorRect/VBoxContainer/HBoxContainer/confirm
@onready var cancel: Button = $ColorRect/VBoxContainer/HBoxContainer/cancel
@onready var button_continue: Button = $"../Control/VBoxContainer/ButtonContinue"

func _ready() -> void:
	file_select.delete_game.connect(confirm_delete)
	cancel.pressed.connect (cancel_delete)
	
func confirm_delete(file:String)->void:
	filename.text = file
	visible=true
	confirm.pressed.connect(delete_game.bind(file))
	cancel.grab_focus()
	
func delete_game(file)->void:
	var dir = DirAccess.open("user://")
	dir.remove(file)
	file_select.validate_slots()
	visible=false
	
func cancel_delete() -> void:
	confirm.pressed.disconnect (delete_game)
	visible=false
	button_continue.grab_focus()
	
	
