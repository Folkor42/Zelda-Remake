extends Node

signal room_entered(room)
signal map_cords(x,y)
signal dungeon_map_cords(x,y)
signal map_cords_left(x,y)
signal item_used(item)
signal bomb_used()
signal bow_used()
signal boomerang_used()
signal candle_used()
signal secret_revealed_sound
signal stop_time()
signal filename_set(filename)
signal dungeon_map_update()
signal toggle_graphics(upgraded_graphics)
signal dungeon_entered

func _ready() -> void:
	item_used.connect(item_signal)	
	
func ignore_me()->void:
	room_entered.emit(null)
	map_cords.emit(null,null)
	map_cords_left.emit(null,null)
	dungeon_map_cords.emit(null,null)
	dungeon_map_update.emit()
	filename_set.emit (null)
	toggle_graphics.emit(null)
	dungeon_entered.emit(null)
	
func item_signal(item)->void:
	if item == "Bomb":
		bomb_used.emit()
	if item == "Bow":
		bow_used.emit()
	if item == "Boomerang":
		boomerang_used.emit()
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

func stopwatch_pickedup()->void:
	stop_time.emit()
