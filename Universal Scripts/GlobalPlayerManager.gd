extends Node

const PLAYER = preload("res://Scenes/link2.tscn")

signal interact_pressed
signal camera_shook ( trama : float )

var interact_handled : bool = true
var player : Player
var player_spawned : bool = false
var inventory : InventoryData
var rubies : int = 0
var bombs : int = 0
var max_bombs : int = 8
var keys : int = 0
var kill_count : int = 0
var sword : String = ""

func _ready() -> void:
	inventory = InventoryData.new()
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	pass

func update_sword( new_sword : String ) -> void:
	if new_sword == "Magic Sword" or sword == "Magic Sword":
		sword = "Magic Sword"
		player.hurt_box.damage=4
	elif new_sword == "White Sword" or sword == "White Sword":
		sword = "White Sword"
		player.hurt_box.damage=2
	elif new_sword == "Wooden Sword" or sword == "Wooden Sword":
		sword = "Wooden Sword"
		player.hurt_box.damage=1
	else:
		sword = ""
		player.hurt_box.damage=0
	PlayerHud.b_item.update_b()

func add_player_instance () -> void:
	player = PLAYER.instantiate()
	add_child( player )
	pass

func set_health( hp : int , max_hp : int ) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp( 0 )
	pass
	
func set_player_position( _new_pos : Vector2 ) -> void:
	player.global_position = _new_pos
	pass


func set_as_parent ( _p : Node2D ) -> void:
	if player.get_parent():
		player.get_parent().remove_child( player )
	_p.add_child( player )
	pass
	
func unparent_player ( _p : Node2D ) -> void:
	_p.remove_child( player )
	pass

func play_audio ( _audio : AudioStream ) -> void:
	player.audio.stream = _audio
	player.audio.play()
	pass

func shake_camera ( tramua : float = 1 ) -> void:
	camera_shook.emit( tramua )
	pass

func interact() -> void:
	interact_handled=false
	interact_pressed.emit()

func update_rubies( _c : int ) ->void:
	if _c > 0:
		for i in _c:
			#print(i)
			PlayerManager.rubies = clampi( PlayerManager.rubies + 1, 0, 255 )
			PlayerHud.update_rubies()
			await get_tree().create_timer(.05).timeout
	else:
		_c *= -1
		for i in _c:
			#print(i)
			PlayerManager.rubies = clampi( PlayerManager.rubies - 1, 0, 255 )
			PlayerHud.update_rubies()
			await get_tree().create_timer(.05).timeout

func update_bombs( _c : int) ->void:
	PlayerManager.bombs = clampi( PlayerManager.bombs + _c, 0, max_bombs )
	PlayerHud.update_bombs()

func increase_kill_counter () -> void:
	kill_count += 1
	if kill_count >= 10:
		kill_count = 0

func update_keys( _c : int ) ->void:
	PlayerManager.keys = clampi( PlayerManager.keys + _c, 0, 255 )
	PlayerHud.update_keys()
