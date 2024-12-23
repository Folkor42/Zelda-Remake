class_name InventoryData extends Node

var contents : Dictionary={}

func add_item ( item : ItemData, count : int = 1 ) -> bool:
	if contents.has(item.name):
		contents[item.name]+=count
	else:
		contents[item.name]=count
	print (contents)
	return true
	
func use_item ( item : ItemData, count : int = 1 ) -> bool:
	
	return false
