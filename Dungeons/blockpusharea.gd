class_name BlockPushArea extends Area2D

enum SIDE { TOP, BOTTOM, LEFT, RIGHT }

@export var direction : SIDE = SIDE.TOP

signal unlocked

var on_door_mat : bool = false
var unlock_time : float = 0.3
var unlock_timer : float = 0
var input_direction : String = ""
var move_to_position : Vector2
var opened : bool = false

func _ready() -> void:
	get_parent().moved.connect(moved)
	get_parent().reset.connect(reset)
	body_entered.connect (check_for_unlock)
	body_exited.connect (stop_check_for_unlock)
	if direction == SIDE.TOP:
		input_direction = "move_up"
		move_to_position=Vector2(0,-16)
	elif direction == SIDE.BOTTOM:
		input_direction = "move_down"
		move_to_position=Vector2(0,16)
	elif direction == SIDE.LEFT:
		input_direction = "move_left"
		move_to_position=Vector2(-16,0)
	elif direction == SIDE.RIGHT:
		input_direction = "move_right"
		move_to_position=Vector2(16,0)

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
			if Input.is_action_pressed(input_direction):
				unlock_timer+=delta
		if unlock_timer>=unlock_time:
			if await move_block():
				unlocked.emit()
			else:
				unlock_timer=0

func move_block() -> bool:
	print ("Pushed")
	opened=true
	var tween = create_tween()
	var start = get_parent().position
	print("Move:" + str(start)+" by "+ str(move_to_position))
	var final_position=get_parent().position+move_to_position
	tween.tween_property(get_parent(),"position",final_position,1)
	await get_tree().create_timer(1).timeout
	print("MOVED BLOCK")
	print(get_parent().position)
	return true
	
func moved()->void:
	opened=true

func reset()->void:
	opened=false
