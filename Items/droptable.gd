class_name DropTable extends Resource

@export var group : String
@export_range(0, 100, 1, "suffix:%") var drop_rate : int
@export var drops : Array [ ItemData ]

func get_drop(turn)->ItemData:
	if drops.size() == 0 or turn > drops.size():
		return null
	var drop = drops[turn]
	if get_drop_count():
		return drop
	else:
		return null

func get_drop_count() -> bool:
	if randf_range(0,100)>= drop_rate:
		return false
	return true
