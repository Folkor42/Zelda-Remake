extends Label

@onready var item_dropper: ItemDropper = $"../ItemDropper"

func _ready()->void:
	item_dropper.dropped.connect(show_text)

func show_text ( ) -> void:
	print ("SHOW VALUE")
	#visible=true
	#item_dropper.dropped.disconnect( show_text )
		
