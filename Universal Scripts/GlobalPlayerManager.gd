extends Node

const PLAYER = preload("res://Scenes/link2.tscn")

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
var active_item : String = ""
var grid = []
var grid_width = 8
var grid_height = 8
var in_dungeon: bool = false
var time_played : float = 0.0
var upgraded_graphics : bool = true

func _ready() -> void:
	Events.dungeon_map_cords.connect(_update_dungeon_map)
	for i in grid_width:
		grid.append([])
		for j in grid_height:
			grid[i].append(false) # Set a starter value for each position
	inventory = InventoryData.new()
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	update_sword ("Wooden Sword")
	pass

func _update_dungeon_map ( x : int, y : int ) -> void:
	grid[x][y]=true
	print (grid)
	pass

func change_graphics ()->void:
	upgraded_graphics = !upgraded_graphics
	Events.toggle_graphics.emit(upgraded_graphics)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_graphics"):
		change_graphics()

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

func update_active_item(item : String, rect : Rect2 = Rect2(0,0,0,0))->void:
	player.equipped_item.remove_equipped()
	active_item = item
	PlayerHud.a_item.update(rect)
	player.equipped_item.equip_item(active_item)
	# TODO Swap out Equipped Item Script

func add_player_instance () -> void:
	player = PLAYER.instantiate()
	add_child( player )
	pass

func set_health( hp : int , max_hp : int = player.max_hp ) -> void:
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
	Events.item_used.emit(active_item)

func update_rubies( _c : int, slow : bool = true ) ->void:
	if _c > 0:
		for i in _c:
			#print(i)
			PlayerManager.rubies = clampi( PlayerManager.rubies + 1, 0, 255 )
			PlayerHud.update_rubies()
			if slow:
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

func _process(delta: float) -> void:
	time_played += delta
