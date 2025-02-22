@tool
class_name ItemPickup extends CharacterBody2D

signal picked_up

@export var item_data : ItemData : set = _set_item_data
@onready var timer: Timer = $Timer

var major_drop : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d : Area2D = $Area2D
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var item_drop: PersistantDataHandler = $ItemDrop
var pickup_audio = preload("res://Assets/Audio/Sounds/Sound Effect (4) - Pickup.wav")
var major_pickup_audio = preload("res://Assets/Audio/Music/04 Item Jingle.mp3")
var blink : float = 0

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area_2d.body_entered.connect ( _on_body_entered )
	if !major_drop:
		area_2d.area_entered.connect ( _on_area_entered )
	await get_tree().create_timer(1).timeout
	#item_drop.set_drop_value(global_position,item_data)
	Events.toggle_graphics.connect(toggle_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	_update_texture()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if item_data.animated:
		blink += delta
		if blink < .2:
			sprite_2d.frame = 0
		elif blink <.4:
			sprite_2d.frame = 1
		else:
			blink=0
	
func _physics_process(_delta: float) -> void:
	pass

func _set_item_data ( value : ItemData ) -> void:
	item_data = value
	_update_texture()
	pass

func _on_area_entered ( a ) -> void:
	if a is Boomerang:
		if item_data:
			print ("Attempting to pick up with a flying drone!")
			if PlayerManager.inventory.add_item ( item_data ) == true:
				item_picked_up( item_data.name )
				area_2d.area_entered.disconnect( _on_area_entered )
	pass


func _on_body_entered ( b ) -> void:
	if b is Player:
		if item_data:
			print ("Picking up!")
			if PlayerManager.inventory.add_item ( item_data ) == true:
				item_picked_up( item_data.name )
				area_2d.body_entered.disconnect( _on_body_entered )
	pass
	
func item_picked_up ( _name : String ) -> void:
	
	if major_drop:
		audio_stream_player_2d.stream=major_pickup_audio
		PlayerManager.player.major_pickup()
		animation_player.play("Pickup")
	else:
		audio_stream_player_2d.stream=pickup_audio
	audio_stream_player_2d.play()
	visible = false
	picked_up.emit()
	PlayerHud.update_display_pickup (_name)
	if major_drop:
		global_position.x = PlayerManager.player.global_position.x
		global_position.y = PlayerManager.player.global_position.y - 4
		visible = true
		await animation_player.animation_finished
		visible = false
	else:
		await audio_stream_player_2d.finished
	#item_drop.clear_drop_value()
	queue_free()
	pass
	
func _update_texture() -> void:
	if item_data and sprite_2d and PlayerManager.upgraded_graphics == false:
		if item_data.animated:
			sprite_2d.hframes=item_data.h_frames
			sprite_2d.vframes=item_data.v_frames
			print("Animated")
		sprite_2d.texture = item_data.texture
	elif item_data and sprite_2d and PlayerManager.upgraded_graphics == true:
		if item_data.animated:
			sprite_2d.hframes=item_data.h_frames
			sprite_2d.vframes=item_data.v_frames
			print("Animated")
		sprite_2d.texture = item_data.snes_texture
	pass

func bounce() -> void:
	$AnimationPlayer.play("bounce")
	
func start_timer()->void:
	$Timer.timeout.connect ( clear_drop )
	pass
	
func clear_drop ()->void:
	queue_free()
