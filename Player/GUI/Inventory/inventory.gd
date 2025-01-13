class_name InventoryData extends Node

var contents : Dictionary={}

func add_item ( item : ItemData, count : int = 1 ) -> bool:
	if item.name == "Ruby":
		PlayerManager.update_rubies(item.value)
	elif item.name == "Blue Ruby":
		PlayerManager.update_rubies(item.value)
	elif item.name == "Transaction":
		PlayerManager.update_rubies(item.value)
	elif item.name == "Heart":
		PlayerManager.set_health(PlayerManager.player.hp+2,PlayerManager.player.max_hp)
	elif item.name == "Fairy":
		PlayerManager.set_health(PlayerManager.player.hp+6,PlayerManager.player.max_hp)
	elif item.name == "Heart Container":
		PlayerManager.set_health(PlayerManager.player.max_hp+2,PlayerManager.player.max_hp+2)
	elif item.name == "Bomb":
		PlayerManager.update_bombs(4)
	elif item.name == "Key":
		PlayerManager.update_keys(1)
	elif item.name == "Wooden Sword" or item.name == "White Sword" or item.name == "Magic Sword" :
		PlayerManager.update_sword (item.name)
	#elif contents.has(item.name):
		#contents[item.name]+=count
	else:
		contents[item.name]=count
	print (contents)
	return true
	
func use_potion ( _item : ItemData, _count : int = 1 ) -> bool:
	if contents.has(_item.name):
		print ("Found: " + _item.name)
		if _item.name == "Red Potion":
			add_item(load("res://Items/blue_potion.tres"))
		contents.erase(_item.name)
		PlayerManager.update_active_item ("")
		return true
	else:
		print ("NOT FOUND!")
	return false
