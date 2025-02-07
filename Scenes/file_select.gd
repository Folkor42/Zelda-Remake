extends CanvasLayer

signal new_game_started
signal delete_game(slot_id:int)
signal cancel_delete

@onready var button_1: Button = $Control/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button1
@onready var button_2: Button = $Control/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button2
@onready var button_3: Button = $Control/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button3
@onready var button_continue: Button = $Control/VBoxContainer/ButtonContinue
@onready var button_start: Button = $Control/VBoxContainer/ButtonStart
@onready var button_delete: Button = $Control/VBoxContainer/ButtonDelete

var selected_slot : int = 0

func _ready() -> void:
	button_delete.pressed.connect (delete_pressed)
	button_1.pressed.connect(slot_selected.bind(1))
	button_2.pressed.connect(slot_selected.bind(2))
	button_3.pressed.connect(slot_selected.bind(3))

func slot_selected(slot_id)->void:
	selected_slot=slot_id
	
func delete_pressed() -> void:
	if selected_slot == 0:
		return
	delete_game.emit(selected_slot)
