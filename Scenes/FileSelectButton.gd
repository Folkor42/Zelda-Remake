extends Button

@export var slot_id : int

@export_category("Debug")
#@export var valid_game : bool = false
var valid_game : bool

@onready var button_continue: Button = $"../../../../ButtonContinue"
@onready var button_start: Button = $"../../../../ButtonStart"
@onready var button_delete: Button = $"../../../../ButtonDelete"
@onready var file_select: CanvasLayer = $"../../../../../.."
@onready var name_label: Label = $HBoxContainer/NameLabel
@onready var time_label: Label = $HBoxContainer/TimeLabel


func _ready() -> void:
	toggled.connect(select_slot)
	
func select_slot( _toggled ) -> void:	
	if valid_game:
		button_continue.disabled = false
		button_start.disabled = true
		button_delete.disabled=false
	else:
		button_continue.disabled = true
		button_start.disabled = false
		button_delete.disabled=true

func load_defaults()->void:
	var initial_save_info : Dictionary 
	initial_save_info = {"name":"-","time_played":0.0}
	name_label.text = str(initial_save_info["name"])
	time_label.text = str(seconds2hhmmss(initial_save_info["time_played"]))
	
		
func load_details(filename : String)->void:
	var save_file = FileAccess.open(filename, FileAccess.READ)
	var initial_save_info : Dictionary
	var json = JSON.new()
	#initial_save = {"name":text_edit.text,"time_played":0}
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			valid_game=false
			continue
		initial_save_info=JSON.parse_string(json_string)
		print(initial_save_info)
		name_label.text = str(initial_save_info["name"])
		time_label.text = str(seconds2hhmmss(initial_save_info["time_played"]))
		valid_game=true
		print (JSON.parse_string(json_string)	)
		
func validate_save_slot(slot : int, slot_button : Button ) -> bool:
	var filename = "user://"+str(slot)+".save"
	if FileAccess.file_exists(filename):
		print ("Slot "+str(slot)+" has a valid save!")
		slot_button.load_details(filename)
		return true
	else:
		print ("Slot "+str(slot)+" does not have a valid save.")
		slot_button.load_defaults()
		valid_game=false
		return false	

func seconds2hhmmss(total_seconds: float) -> String:
	#total_seconds = 12345
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	var hours:  int   =  int(total_seconds / 3600.0)
	var hhmmss_string:String = "%02d:%02d:%02d" % [hours, minutes, seconds]
	return hhmmss_string
