extends StaticBody2D

@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.Damaged.connect (check_for_key)
	print ("Door Ready!")
	pass
	
func check_for_key(_a) -> void:
	print (_a)
	print ("Checking for Key")
	if PlayerManager.keys >= 1:
		print ("Unlocked")
		queue_free()
	else:
		print ("You don't have a key!")
	
