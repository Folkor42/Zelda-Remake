class_name InventoryData extends Node

var contents : Dictionary={}

func add_item ( item : ItemData, count : int = 1 ) -> bool:
	if item.name == "Ruby":
		PlayerManager.update_rubies(1)
	elif item.name == "Blue Ruby":
		PlayerManager.update_rubies(5)
	elif item.name == "Bomb":
		PlayerManager.update_bombs(1)
	elif item.name == "Key":
		PlayerManager.update_keys(1)
	elif contents.has(item.name):
		contents[item.name]+=count
	else:
		contents[item.name]=count
	print (contents)
	return true
	
func use_item ( _item : ItemData, _count : int = 1 ) -> bool:
	
	return false
