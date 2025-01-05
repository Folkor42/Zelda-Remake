class_name ItemBet extends Node2D

signal selected
signal broke

const PICKUP = preload("res://Items/Item Pickup/item_pickup.tscn")
@export var item_data : ItemData : set = _set_item_data

@onready var sprite: Sprite2D = $Sprite2D
@onready var cost_label: Label = $CostLabel
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var area_2d: Area2D = $Area2D

var cost : int = -10
var result : int = -10
var major_drop : bool = false
var has_dropped : bool = false

func _ready() -> void:
	_update_cost()
	area_2d.body_entered.connect ( check_for_purchase )
	pass # Replace with function body.

func check_for_purchase( _b )->void:
	if PlayerManager.rubies - -cost < 0:
		print ("You don't have enough Money")
		broke.emit()
	else:
		selected.emit()
		PlayerManager.update_rubies(cost)
		print ("You won: " + str(result))
		PlayerManager.update_rubies(result)
		#drop_item()

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
	if item_data and sprite:
		sprite.texture = item_data.texture
	pass
	
func _update_cost() -> void:
	print ("Updating Costs")
	if item_data and cost_label:
		cost = item_data.value
		cost_label.text = str(cost)
	pass

func _update_result() -> void:
	print ("Updating Results")
	cost_label.text = str(result)
	area_2d.body_entered.disconnect ( check_for_purchase )
	pass
	
func _too_broke() -> void:
	area_2d.body_entered.disconnect ( check_for_purchase )
	pass

func _on_drop_pickup () -> void:
	await get_tree().create_timer(1).timeout
	queue_free()
	pass
