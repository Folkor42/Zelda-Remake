class_name DoorMat extends Area2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

signal unlocked

var on_door_mat : bool = false
var unlock_time : float = 0.3
var unlock_timer : float = 0
var direction : String = ""
var opened : bool = false

func _ready() -> void:
	body_entered.connect (check_for_unlock)
	body_exited.connect (stop_check_for_unlock)
	if get_parent().direction == SIDE.TOP:
		direction = "move_up"
	elif get_parent().direction == SIDE.BOTTOM:
		direction = "move_down"
	elif get_parent().direction == SIDE.LEFT:
		direction = "move_left"
	elif get_parent().direction == SIDE.RIGHT:
		direction = "move_right"
func check_for_unlock(_b)->void:
	if _b is Player:
		on_door_mat=true
	pass
	
func stop_check_for_unlock(_b)->void:
	on_door_mat=false
	unlock_timer=0
	pass
	
func _process(delta: float) -> void:
	if !opened:
		if on_door_mat:
			if Input.is_action_pressed(direction):
				unlock_timer+=delta
		if unlock_timer>=unlock_time:
			if check_for_key():
				unlocked.emit()
			else:
				unlock_timer=0

func check_for_key() -> bool:
	if PlayerManager.keys >= 1:
		print ("Unlocked")
		PlayerManager.update_keys(-1)
		opened=true
		return true
	print ("You don't have a key!")
	return false
