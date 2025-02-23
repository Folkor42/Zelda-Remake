@tool
class_name ItemBuy extends Node2D

const PICKUP = preload("res://Items/Item Pickup/item_pickup.tscn")

@export var item_data : ItemData : set = _set_item_data

@onready var sprite: Sprite2D = $Sprite2D
@onready var cost_label: Label = $CostLabel
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area_2d: Area2D = $Area2D

var cost : int = 0
var major_drop : bool = true
var has_dropped : bool = false

func _ready() -> void:
	_update_texture()
	_update_cost()
	if Engine.is_editor_hint()==true:
		return
	area_2d.body_entered.connect ( check_for_purchase )
	_on_data_loaded()
	Events.toggle_graphics.connect(toggle_graphics)
	pass # Replace with function body.

func check_for_purchase( _b )->void:
	if PlayerManager.rubies - cost < 0:
		print ("You don't have enough Money")
	else:
		PlayerManager.update_rubies(-cost)
		drop_item()

func drop_item() -> void:
	if has_dropped:
		return
	has_dropped = true
	var drop = PICKUP.instantiate() as ItemPickup
	drop.major_drop=major_drop
	drop.item_data = item_data
	call_deferred("add_child", drop )
	drop.picked_up.connect( _on_drop_pickup )
	audio.play()
	pass

func _set_item_data ( value : ItemData ) -> void:
	item_data = value
	_update_cost()
	_update_texture()
	pass

func _update_texture() -> void:
	if Engine.is_editor_hint()==true:
		sprite.texture = item_data.texture
		return
	if item_data and sprite and PlayerManager.upgraded_graphics == false:
		if item_data.animated:
			sprite.hframes=item_data.h_frames
			sprite.vframes=item_data.v_frames
			print("Animated")
		sprite.texture = item_data.texture
	elif item_data and sprite and PlayerManager.upgraded_graphics == true:
		if item_data.animated:
			sprite.hframes=item_data.h_frames
			sprite.vframes=item_data.v_frames
			print("Animated")
		sprite.texture = item_data.snes_texture
	pass
	
func _update_cost() -> void:
	print ("Updating Costs")
	if item_data and cost_label:
		cost = item_data.value
		cost_label.text = str(cost)
	pass

func _on_drop_pickup () -> void:
	await get_tree().create_timer(1).timeout
	queue_free()
	pass

func _on_data_loaded () -> void:
	#has_dropped=has_dropped_data.value
	pass

func toggle_graphics( _new_value : bool )->void:
	_update_texture()
