extends CanvasLayer

signal delete_game ( filename:String )
signal slot_changed ( slot_id:int )

@onready var button_1: Button = $Control/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button1
@onready var button_2: Button = $Control/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button2
@onready var button_3: Button = $Control/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button3
@onready var button_continue: Button = $Control/VBoxContainer/ButtonContinue
@onready var button_start: Button = $Control/VBoxContainer/ButtonStart
@onready var button_delete: Button = $Control/VBoxContainer/ButtonDelete
@onready var name_new_game: CanvasLayer = $"Name New Game"
@onready var loading_overlay: CanvasLayer = $LoadingOverlay
@onready var confirm_delete: CanvasLayer = $"Confirm Delete"

var selected_slot : int = 0
var filename : String

func _ready() -> void:
	button_delete.pressed.connect (delete_pressed)
	button_start.pressed.connect (start_pressed)
	button_continue.pressed.connect(continue_pressed)
	button_1.pressed.connect(slot_selected.bind(1))
	button_2.pressed.connect(slot_selected.bind(2))
	button_3.pressed.connect(slot_selected.bind(3))
	validate_slots()
	button_1.grab_focus()

func slot_selected(slot_id)->void:
	selected_slot=slot_id
	slot_changed.emit(slot_id)
	filename = "user://"+str(slot_id)+".save"

func validate_slots()->void:
	button_1.validate_save_slot(1,button_1)
	button_1.set_pressed(false)
	button_2.validate_save_slot(2,button_2)
	button_2.set_pressed(false)
	button_3.validate_save_slot(3,button_3)
	button_3.set_pressed(false)
	button_delete.disabled=true
	button_start.disabled=true
	button_continue.disabled=true
	
func delete_pressed() -> void:
	if selected_slot == 0:
		return
	delete_game.emit(filename)
	
func start_pressed() -> void:
	if selected_slot == 0:
		return
	name_new_game.show_new_game_screen(selected_slot)
	Events.filename_set.emit(filename)

func continue_pressed()->void:
	loading_overlay.visible=true
	PlayerHud.visible=true
	PlayerManager.player.visible=true
	PlayerManager.player_spawned=false
	Events.filename_set.emit(filename)
	SaveManager.load_game()
