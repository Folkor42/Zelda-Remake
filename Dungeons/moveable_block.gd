class_name MoveableBlock extends StaticBody2D

signal moved
signal reset

@onready var push_up: BlockPushArea = $PushUp
@onready var push_down: BlockPushArea = $PushDown
@onready var push_right: BlockPushArea = $PushRight
@onready var push_left: BlockPushArea = $PushLeft

var home

func _ready() -> void:
	home = position
	if get_parent().get_parent().has_signal("activate"):
		get_parent().get_parent().deactivate.connect(reset_block)
	push_up.unlocked.connect(block_moved)
	push_down.unlocked.connect(block_moved)
	push_left.unlocked.connect(block_moved)
	push_right.unlocked.connect(block_moved)

func reset_block()->void:
	await get_tree().create_timer(.2).timeout
	position = home
	reset.emit()
	
func block_moved()->void:
	moved.emit()
