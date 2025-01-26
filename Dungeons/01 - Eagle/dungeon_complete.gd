extends Node2D

@onready var triforce: ItemDropper = $Triforce
@export_file( "*.tscn" ) var level
@export var target_transition_area : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	triforce.item_dropped.connect( triforce_grabbed )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func triforce_grabbed () ->void:
	print("Triforce Picked Up")
	$AudioStreamPlayer2D.play()
	await get_tree().process_frame
	await get_tree().process_frame
	PlayerManager.player.cardinal_direction=Vector2.DOWN
	PlayerManager.player.process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(8).timeout
	PlayerManager.player.process_mode = Node.PROCESS_MODE_ALWAYS
	await $AudioStreamPlayer2D.finished
	print ("WARPING OUTSIDE")
	LevelManager.load_new_level( level, target_transition_area, Vector2.ZERO )
	pass
