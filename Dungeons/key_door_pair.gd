extends Node2D

@onready var opened: PersistantDataHandler = $Opened
var doors : Array [KeyDoor] = []
var is_opened : bool = false

func _ready() -> void:
	opened.data_loaded.connect( set_state )
	for i in get_children():
		if i is KeyDoor:
			doors.append(i)
			i.unlocked.connect (unlock_door)
	
	set_state()
	
func set_state() -> void:
	if opened.value:
		is_opened=true
		open_doors()

func unlock_door()->void:
	opened.set_value()
	open_doors()
	
func open_doors()->void:
	for i in doors:
		i.queue_free()
	
	pass
