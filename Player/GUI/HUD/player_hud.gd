extends CanvasLayer

@export var button_focus_audio : AudioStream = preload("res://Assets/Audio/Sounds/menu_focus.wav")
@export var button_select_audio : AudioStream = preload("res://Assets/Audio/Sounds/menu_select.wav")

var hearts : Array[ HeartGUI ] = []
@onready var pickup_label = $Control/PickupLabel
@onready var timer = $Control/PickupLabel/Timer
@onready var game_over: Control = $GameOver

@onready var title_button = $GameOver/VBoxContainer/ButtonQuit
@onready var continue_button = $GameOver/VBoxContainer/ButtonContinue
@onready var animation_player = $GameOver/AnimationPlayer
@onready var audio = $AudioStreamPlayer
#@onready var boss_ui = $Control2/BossUI
#@onready var boss_hp__bar = $Control2/BossUI/TextureProgressBar
#@onready var boss_label = $Control2/BossUI/Label
@onready var rubies: Label = $Control/Rubies
@onready var bombs: Label = $Control/Bombs
@onready var keys: Label = $Control/Keys
@onready var kill_counter: Label = $DEBUG/HBoxContainer/KillCounter
@onready var b_item: Sprite2D = $"Control/B-Item"
@onready var a_item: Sprite2D = $"Control/A-Item"
@onready var over_world_map: GridContainer = $Control/OverWorldMap




func _ready():
	#hide_boss_health()
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append( child )
			child.visible = false
	timer.connect("timeout", _on_timer_timeout)
	update_rubies()
	update_bombs()
	update_keys()
	LevelManager.level_loaded.connect(map_select)
	hide_game_over_screen()
	title_button.grab_focus()
	continue_button.focus_entered.connect( button_focused.bind(continue_button) )
	continue_button.pressed.connect( load_game )
	title_button.focus_entered.connect( button_focused.bind(title_button) )
	title_button.pressed.connect( title_screen )
	LevelManager.level_load_started.connect(hide_game_over_screen)
	pass # Replace with function body.
func button_focused( _b : Button ) -> void:
	play_audio( button_focus_audio )

	
func hide_game_over_screen()->void:
	game_over.visible=false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color(1,1,1,0)
	pass

func show_game_over_screen()->void:
	game_over.visible=true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var can_continue : bool = SaveManager.get_save_file() != null
	continue_button.visible = can_continue
	
	animation_player.play("show_game_over")
	await animation_player.animation_finished
		
	#focus a button
	if can_continue:
		continue_button.grab_focus()
	else:
		title_button.grab_focus()
		
	pass

func title_screen() -> void:
	play_audio( button_select_audio )
	SaveManager.save_game()
	await fade_to_black()
	PlayerManager.reset_values()
	LevelManager.load_new_level("res://Scenes/title_screen.tscn","",Vector2.ZERO)	
	pass

func fade_to_black() -> bool:
	animation_player.play("fade_to_black")
	PlayerHud.visible=false	
	await animation_player.animation_finished
	var level = ""
	PlayerManager.player.revive_player( level )
	return true

func update_hp ( _hp : int, _max_hp : int ) -> void:
	update_max_hp( _max_hp )
	@warning_ignore("integer_division")
	var max_heart = _max_hp/2
	for i in max_heart:
		update_heart ( i , _hp )
		pass
	pass

func update_heart ( _index : int, _hp : int ) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2 )
	hearts[ _index ].value = _value
	pass

func update_rubies ( ) -> void:
	rubies.text = str(PlayerManager.rubies)
	pass

func update_bombs ( ) -> void:
	bombs.text = str(PlayerManager.bombs)
	pass
	
func update_keys ( ) -> void:
	keys.text = str(PlayerManager.keys)
	pass
	
func update_max_hp ( _max_hp : int ) -> void:
	@warning_ignore("integer_division")
	var _heart_count : int = roundi ( _max_hp / 2 )
	for i in hearts.size():
		if i < _heart_count :
			hearts[i].visible = true
		else: 
			hearts[i].visible = false
	pass

func update_display_pickup ( text : String ) ->void:
	if timer.is_stopped():
		pickup_label.text = text
		timer.start()
	else:
		pickup_label.text +="\n" + text
		timer.start()
	pass
	
func _on_timer_timeout() -> void:
	pickup_label.text = ""
	pass

func play_audio( _a : AudioStream ) -> void:
	audio.stream = _a
	audio.play()
	pass

func _process(_delta: float) -> void:
	kill_counter.text=str(PlayerManager.kill_count)

func load_game() -> void:
	play_audio( button_select_audio )
	SaveManager.save_game()
	await fade_to_black()
	LevelManager.load_new_level("res://Scenes/load_screen.tscn","",Vector2.ZERO)
	await LevelManager.level_loaded
	PlayerManager.player.revive_player("res://Overworld/over_world_quest_1.tscn")
	pass
	
#func title_screen() -> void:
	#play_audio( button_select_audio )
	#await fade_to_black()
	#LevelManager.load_new_level("res://scenes/Title Screen.tscn","",Vector2.ZERO)	
	#pass

#func fade_to_black() -> bool:
	#animation_player.play("fade_to_black")
	#await animation_player.animation_finished
	#PlayerManager.player.revive_player()
	#
	#return true

#func hide_boss_health () -> void:
	#boss_ui.visible=false
	#pass

#func show_boss_health ( boss_name : String, boss_hp : int ) -> void:
	#boss_label.text=boss_name
	#boss_hp__bar.max_value=boss_hp
	#update_boss_health(boss_hp,boss_hp)
	#boss_ui.visible=true
	#pass

#func update_boss_health( hp : int, max_hp : int ) -> void:
	#boss_hp__bar.value=clampi(hp,0,max_hp)
	#pass

func _unhandled_input(_event):
	#if _event.is_action_pressed("test"):
		#PlayerManager.shake_camera()
	if _event.is_action_pressed("pause"):
		if get_tree().paused:
			get_tree().paused=false
		else:
			get_tree().paused=true


func map_select() -> void:
	if PlayerManager.in_dungeon:
		over_world_map.visible=false
	else:
		over_world_map.visible=true
	pass
