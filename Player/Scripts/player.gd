class_name Player extends CharacterBody2D

signal player_pickup

const inv : PackedScene = preload ("res://Player/GUI/Inventory/inventory.tscn")
const SNES_LINK : Texture = preload("res://Assets/SpriteSheets/SNES - Link.png")
const NES_LINK : Texture = preload("res://Assets/SpriteSheets/NES - The Legend of Zelda - Link-3.png")

var menu_opened : bool = false

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO
var terminal_velocity = 5000
var last_input_type: String = "Keyboard"

@onready var stop_watch: AudioStreamPlayer = $StopWatch
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine: Node = $"Player State Machine"
@onready var hit_box : HitBox = $HitBox
#@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer
@onready var audio = $AudioStreamPlayer2D
#@onready var pickup: State_Pickup = $StateMachine/Pickup
#@onready var held_item: Sprite2D = $Sprite2D/HeldItem
#@onready var carry = $StateMachine/Carry
@onready var shield: Area2D = $Shield
@onready var shield_block_sound: AudioStreamPlayer2D = $Shield/ShieldBlockSound
@onready var hurt_box: HurtBox = $Sprite2D/Sword/HurtBox
@onready var equipped_item: Node = $EquippedItem
@onready var sword: Sprite2D = $Sprite2D/Sword
@onready var label: Label = $Label

signal DirectionChanged ( new_direction : Vector2 )
signal player_damaged ( hurt_box : HurtBox )

var invulnerable : bool = false
var gravity_active : bool = false

@export var hp : int = 6
@export var max_hp : int = 6

func _ready():
	#PlayerManager.player = self
	state_machine.Initialize( self )
	hit_box.Damaged.connect ( _take_damage )
	Events.stop_time.connect ( tick_tok )
	update_hp( 99 )
	Events.toggle_graphics.connect(toggle_graphics)
		
func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_LINK
		sword.texture=SNES_LINK
	else:
		sprite.texture=NES_LINK
		sword.texture=NES_LINK
	
func tick_tok () -> void:
	var music_index= AudioServer.get_bus_index("Music")
	var music_vol = AudioServer.get_bus_volume_db(music_index)
	AudioServer.set_bus_volume_db(music_index, music_vol-10)
	stop_watch.play()
	await stop_watch.finished
	AudioServer.set_bus_volume_db(music_index, music_vol)
	pass	
	
func _process( _delta ):
	#detect_input()
	direction = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()

func detect_input():
	# Detect joystick input
	for i in range(Input.get_connected_joypads().size()):
		var joystick_name = Input.get_joy_name(i)
		if Input.is_joy_button_pressed(i, 0):  # Checking if any button is pressed on the controller
			if "XInput" in joystick_name:
				update_label("Xbox Controller")
			elif "DualShock" in joystick_name:
				update_label("PlayStation Controller")
			elif "Switch" in joystick_name:
				update_label("Switch Controller")
			else:
				update_label("Unknown Controller")
			return
		# Detect keyboard input
		elif Input.is_anything_pressed():
			update_label("Keyboard")

func update_label(new_input_type: String):
	if last_input_type != new_input_type:
		last_input_type = new_input_type
		label.text = new_input_type  # Change this based on your UI element


	
func _physics_process( _delta ):
	if gravity_active and !self.is_on_floor():
		if velocity.y < terminal_velocity:
			velocity.y += terminal_velocity*_delta
		elif velocity.y > terminal_velocity:
				velocity.y = terminal_velocity*_delta
		velocity.x=0
	move_and_slide()

func major_pickup()->void:
	player_pickup.emit()

func calculate_direction_index(direction_temp: Vector2, cardinal_direction_temp: Vector2, dir_size: int) -> int:
	var direction_bias = 0.1
	var angle = (direction_temp + cardinal_direction_temp * direction_bias).angle()
	var normalized_angle = angle / TAU
	var direction_idx = int(round(normalized_angle * dir_size))
	return direction_idx
	
func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = calculate_direction_index(direction, cardinal_direction, DIR_4.size())
	var new_dir = DIR_4[ direction_id ]
		
	if new_dir == cardinal_direction:
		return false
	cardinal_direction = new_dir
	DirectionChanged.emit( new_dir )
	sprite.scale.x = -1 if cardinal_direction== Vector2.LEFT else 1
	shield.scale.y = -1 if cardinal_direction== Vector2.LEFT else 1
	return true
	
func UpdateAnimation( state : String ) -> void:
	animation_player.play( state + "_" + AnimDirection() )
	pass
	
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage ( _hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	if hp > 0:
		update_hp( -_hurt_box.damage )
		player_damaged.emit( _hurt_box )
	pass
	
func update_hp ( delta : int ) -> void:
	hp = clampi( hp + delta, 0, max_hp )
	PlayerHud.update_hp( hp, max_hp )
	pass
	
func make_invulnerable ( _duration : float = 1.0 ) -> void:
	invulnerable = true
	#hit_box.monitoring = false
	
	await get_tree().create_timer( _duration ).timeout
	invulnerable = false
	#hit_box.monitoring = true
	pass

func _unhandled_input(_event):
	#if _event.is_action_pressed("test"):
		#PlayerManager.shake_camera()
	if _event.is_action_pressed("menu"):
		show_menu()
	if _event.is_action_pressed("use_item"):
		PlayerManager.interact()
	pass
	
func show_menu()->void:
	var menu=get_parent().get_node_or_null("InventoryScreen")
	if menu:
		menu.close_menu()
		return
	else:
		var overlay = inv.instantiate()
		get_parent().add_child(overlay)
		overlay.show_menu()

func revive_player( _level : String) -> void:
	update_hp( 6 )
	var level = "res://Overworld/over_world_quest_1.tscn"
	var target_transition_area = "Cave-SwordA"
	PlayerManager.player.animation_player.play("RESET")
	PlayerHud.visible=true
	#var tween = get_tree().create_tween()
	#tween.tween_method(SetShader_BlinkIntensity,1.0,0.0,1.0)
	state_machine.ChangeState( $"Player State Machine/Idle" )
	LevelManager.load_new_level( level, target_transition_area, Vector2.ZERO )
	pass

func SetShader_BlinkIntensity( newvalue : float) -> void:
	sprite.material.set_shader_parameter("blink_intensity", newvalue)	
	pass	
	
#func pickup_item ( _t : Throwable ) -> void:
	#state_machine.ChangeState(pickup)
	##store throwable object
	#carry.throwable=_t
	#pass

func remove_camera()->void:
	print ("Removing Cameras")
	for c in get_children():
		print(c)
		if c is Camera2D:
			c.queue_free()
			
