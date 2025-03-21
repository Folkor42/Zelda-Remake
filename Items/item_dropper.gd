@tool
class_name ItemDropper extends Node2D

signal item_dropped 

const PICKUP = preload("res://Items/Item Pickup/item_pickup.tscn")
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer
@onready var has_dropped_data: PersistantDataHandler = $PersistantHandler

@export var item_data : ItemData : set = _set_item_data
@export var major_drop : bool = false
@export var start_dropped : bool = true

var has_dropped : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint()==true:
		_update_texture()
		return
	sprite.visible = false
	has_dropped_data.data_loaded.connect( _on_data_loaded )
	_on_data_loaded()
	if start_dropped:
		start_drop_item()
	pass # Replace with function body.

func play_audio()->void:
	if is_inside_tree():
		audio.play()
	
func drop_item() -> void:
	if has_dropped:
		return
	has_dropped = true
	var drop = PICKUP.instantiate() as ItemPickup
	drop.major_drop=major_drop
	drop.item_data = item_data
	add_child( drop )
	drop.picked_up.connect( _on_drop_pickup )
	play_audio()
	pass

func start_drop_item() -> void:
	if has_dropped:
		return
	has_dropped = true
	var drop = PICKUP.instantiate() as ItemPickup
	drop.major_drop=major_drop
	drop.item_data = item_data
	add_child( drop )
	drop.picked_up.connect( _on_drop_pickup )
	pass

func _on_drop_pickup () -> void:
	has_dropped_data.set_value()
	item_dropped.emit()
	pass

func _on_data_loaded () -> void:
	has_dropped=has_dropped_data.value
	pass

func _set_item_data ( value : ItemData ) -> void:
	item_data = value
	_update_texture()
	pass
	
func _update_texture() -> void:
	if Engine.is_editor_hint()==true:
		if item_data and sprite and PlayerManager.upgraded_graphics == false:
			sprite.texture = item_data.texture
		else:
			sprite.texture = item_data.snes_texture
	pass
