extends Button

@export var slot_id : int

@export_category("Debug")
@export var valid_game : bool = false

@onready var button_continue: Button = $"../../../../ButtonContinue"
@onready var button_start: Button = $"../../../../ButtonStart"
@onready var button_delete: Button = $"../../../../ButtonDelete"
@onready var file_select: CanvasLayer = $"../../../../../.."


func _ready() -> void:
	toggled.connect(select_slot)
	file_select.cancel_delete.connect(activate_slot)
	
func select_slot( _toggled ) -> void:	
	if valid_game:
		button_continue.disabled = false
		button_start.disabled = true
		button_delete.disabled=false
	else:
		button_continue.disabled = true
		button_start.disabled = false
		button_delete.disabled=true

func activate_slot ()->void:
	disabled=false
