extends Node

@onready var item_dropper_1: ItemDropper = $ItemDropper1
@onready var item_dropper_2: ItemDropper = $ItemDropper2
@onready var persistant_data_handler: PersistantDataHandler = $ItemChosen
var has_chosen : bool = false

func _ready() -> void:
	persistant_data_handler.data_loaded.connect( _on_data_loaded )
	_on_data_loaded()
	if has_chosen:
		item_dropper_1.queue_free()
		item_dropper_2.queue_free()
		return
	item_dropper_1.item_dropped.connect( clear )
	item_dropper_2.item_dropped.connect( clear )
	pass

func clear()->void:
	has_chosen=true
	persistant_data_handler.set_value()
	await get_tree().create_timer(1).timeout
	item_dropper_1.queue_free()
	item_dropper_2.queue_free()

func _on_data_loaded () -> void:
	has_chosen=persistant_data_handler.value
	print(has_chosen)
