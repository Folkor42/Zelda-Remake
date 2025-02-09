extends Label

func _ready() -> void:
	get_parent().get_parent().toggled.connect(change_text)
	
func change_text (state)->void:
	if state:
		add_theme_color_override("font_color",get_parent().get_parent().get_theme_color("font_pressed_color","Button"))
	else:
		remove_theme_color_override("font_color")	
	
