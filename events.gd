extends Node

signal room_entered(room)
signal map_cords(x,y)
signal item_used(item)
signal bomb_used()
signal bow_used()
signal candle_used()
signal secret_revealed_sound

func _ready() -> void:
	item_used.connect(item_signal)	
	
func ignore_me()->void:
	room_entered.emit(null)
	map_cords.emit(null,null)
	
func item_signal(item)->void:
	if item == "Bomb":
		bomb_used.emit()
	if item == "Bow":
		bow_used.emit()
	if item == "Candle":
		candle_used.emit()
	if item == "Blue Potion":
		PlayerManager.set_health(PlayerManager.player.max_hp,PlayerManager.player.max_hp)
		PlayerManager.inventory.use_potion(load("res://Items/blue_potion.tres"),1)
	if item == "Red Potion":
		PlayerManager.set_health(PlayerManager.player.max_hp,PlayerManager.player.max_hp)
		PlayerManager.inventory.use_potion(load("res://Items/red_potion.tres"),1)
	
func secret_found () -> void:
	print ("SECRET REVEALED")
	secret_revealed_sound.emit()
