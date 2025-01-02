extends Label

@onready var item_dropper: ItemDropper = $"../ItemDropper"
@onready var label: Label = $"../Label"

func _ready()->void:
	if item_dropper.get_node_or_null("ItemPickup"):
		item_dropper.get_node("ItemPickup").picked_up.connect(show_text)
	else:
		label.visible=false

func show_text ( ) -> void:
	visible=true
	item_dropper.get_node("ItemPickup").picked_up.disconnect(show_text)
	await get_tree().create_timer(1).timeout
	visible = false
		
