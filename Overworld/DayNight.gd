extends DirectionalLight2D


func _ready() -> void:
	var time = Time.get_time_dict_from_system()
	if (time.minute / 10 == 0 or time.minute / 10 == 2 or time.minute / 10 == 4):
		energy = 0.0
	else:
		energy = 0.8

func _process(_delta: float) -> void:
	# Get the time dictionary
	var time = Time.get_time_dict_from_system()
	if (time.minute / 10 == 0 or time.minute / 10 == 2 or time.minute / 10 == 4) and energy >= 0.8:
		var tween = create_tween()
		tween.tween_property(self,"energy",0.0,15)
		await tween.finished
	elif (time.minute / 10 == 1 or time.minute / 10 == 3 or time.minute / 10 == 5)  and energy == 0:
		var tween = create_tween()
		tween.tween_property(self,"energy",0.8,15)
		await tween.finished
