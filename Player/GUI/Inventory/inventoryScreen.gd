extends CanvasLayer
@onready var items_background: TextureRect = $VBoxContainer/ItemsBackground
@onready var map_background: TextureRect = $VBoxContainer/MapBackground
@onready var triforce_background: TextureRect = $VBoxContainer/TriforceBackground

@onready var button: Button = $VBoxContainer/ItemsBackground/Control/Button
@onready var button_2: Button = $VBoxContainer/ItemsBackground/Control/Button2
@onready var button_3: Button = $VBoxContainer/ItemsBackground/Control/Button3
@onready var button_4: Button = $VBoxContainer/ItemsBackground/Control/Button4
@onready var button_5: Button = $VBoxContainer/ItemsBackground/Control/Button5
@onready var button_6: Button = $VBoxContainer/ItemsBackground/Control/Button6
@onready var button_7: Button = $VBoxContainer/ItemsBackground/Control/Button7
@onready var button_8: Button = $VBoxContainer/ItemsBackground/Control/Button8
# Equipable Items
@onready var selected_item_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/SelectedItemSprite
@onready var boomerang_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button/BoomerangSprite
@onready var bomb_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button2/BombSprite
@onready var arrow_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button3/ArrowSprite
@onready var bow_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button3/BowSprite
@onready var candle_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button4/CandleSprite
@onready var flute_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button5/FluteSprite
@onready var bait_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button6/BaitSprite
@onready var potion_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button7/PotionSprite
@onready var wand_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/Button8/WandSprite
# Non-Equipable Items
@onready var raft_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/RaftSprite
@onready var magic_book_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/MagicBookSprite
@onready var ring_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/RingSprite
@onready var ladder_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/LadderSprite
@onready var master_key_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/MasterKeySprite
@onready var power_bracelet_sprite: Sprite2D = $VBoxContainer/ItemsBackground/Control/PowerBraceletSprite

@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if PlayerManager.in_dungeon:
		map_background.visible=true
		triforce_background.visible=false
	else:
		map_background.visible=false
		triforce_background.visible=true
	pass

func update_active_items()->void:
	if PlayerManager.inventory.contents.has("Boomerang"):
		button.pressed.connect(equip.bind("Boomerang"))
		boomerang_sprite.visible=true
	else:
		boomerang_sprite.visible=false
	
	if PlayerManager.bombs>0:
		button_2.pressed.connect(equip.bind("Bomb"))
		bomb_sprite.visible=true
	else:
		bomb_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("Bow"):
		bow_sprite.visible=true
	else:
		bow_sprite.visible=false
	if PlayerManager.inventory.contents.has("Arrows"):
		arrow_sprite.visible=true
	else:
		arrow_sprite.visible=false
	if PlayerManager.inventory.contents.has("Bow") and PlayerManager.inventory.contents.has("Arrows"):
			button_3.pressed.connect(equip.bind("Bow"))
		
	if PlayerManager.inventory.contents.has("Blue Candle") or PlayerManager.inventory.contents.has("Red Candle"):
		button_4.pressed.connect(equip.bind("Candle"))
		candle_sprite.visible=true
	else:
		candle_sprite.visible=false
		
	if PlayerManager.inventory.contents.has("Flute"):
		button_5.pressed.connect(equip.bind("Flute"))
		flute_sprite.visible=true
	else:
		flute_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("Bait"):
		button_6.pressed.connect(equip.bind("Bait"))
		bait_sprite.visible=true
	else:
		bait_sprite.visible=false
		
	if PlayerManager.inventory.contents.has("Red Potion") or PlayerManager.inventory.contents.has("Blue Potion"):
		button_7.pressed.connect(equip.bind("Potion"))
		potion_sprite.visible=true
	else:
		potion_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("Wand"):
		button_8.pressed.connect(equip.bind("Wand"))
		wand_sprite.visible=true
	else:
		wand_sprite.visible=false

func equip (item:String)->void:
	if item == "Boomerang":
		selected_item_sprite.region_rect = boomerang_sprite.region_rect
		PlayerManager.update_active_item ("Boomerang", boomerang_sprite.region_rect)
	if item == "Bomb":
		selected_item_sprite.region_rect = bomb_sprite.region_rect
		PlayerManager.update_active_item ("Bomb", bomb_sprite.region_rect)
	if item == "Bow":
		selected_item_sprite.region_rect = arrow_sprite.region_rect
		PlayerManager.update_active_item ("Bow", arrow_sprite.region_rect)
	if item == "Candle":
		selected_item_sprite.region_rect = candle_sprite.region_rect
		PlayerManager.update_active_item ("Candle", candle_sprite.region_rect)
	if item == "Flute":
		selected_item_sprite.region_rect = flute_sprite.region_rect
		PlayerManager.update_active_item ("Flute", flute_sprite.region_rect)
	if item == "Bait":
		selected_item_sprite.region_rect = bait_sprite.region_rect
		PlayerManager.update_active_item ("Bait", bait_sprite.region_rect)
	if item == "Potion":
		if PlayerManager.inventory.contents.has("Red Potion"):
			PlayerManager.update_active_item ("Red Potion", potion_sprite.region_rect)
			selected_item_sprite.region_rect = potion_sprite.region_rect
		elif PlayerManager.inventory.contents.has("Blue Potion"):
			PlayerManager.update_active_item ("Blue Potion", potion_sprite.region_rect)
			selected_item_sprite.region_rect = potion_sprite.region_rect
		else:
			selected_item_sprite.region_rect = potion_sprite.region_rect
			PlayerManager.update_active_item ("")
		
	if item == "Wand":
		selected_item_sprite.region_rect = wand_sprite.region_rect
		PlayerManager.update_active_item ("Wand", wand_sprite.region_rect)
		
	if item == "":
		selected_item_sprite.region_rect = Rect2(495, 145, 7, 16)

func update_passive_items()->void:
	if PlayerManager.inventory.contents.has("Raft"):
		raft_sprite.visible=true
	else:
		raft_sprite.visible=false

	if PlayerManager.inventory.contents.has("MagicBook"):
		magic_book_sprite.visible=true
	else:
		magic_book_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("RedRing") or PlayerManager.inventory.contents.has("BlueRing"):
		ring_sprite.visible=true
	else:
		ring_sprite.visible=false

	if PlayerManager.inventory.contents.has("Ladder"):
		ladder_sprite.visible=true
	else:
		ladder_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("MasterKey"):
		master_key_sprite.visible=true
	else:
		master_key_sprite.visible=false
		
	if PlayerManager.inventory.contents.has("PowerBracelet"):
		power_bracelet_sprite.visible=true
	else:
		power_bracelet_sprite.visible=false

func close_menu()->void:
	anim.play("roll_up")
	await anim.animation_finished
	PlayerManager.player.menu_opened = false
	get_tree().paused=false
	queue_free()
	return
	
func show_menu () -> void:
	get_tree().paused=true
	equip(PlayerManager.active_item)
	update_passive_items()
	update_active_items()	
	$VBoxContainer/ItemsBackground/Control/Button.grab_focus()
	PlayerManager.player.menu_opened = true

func quick_open()->void:
	equip(PlayerManager.active_item)
	update_passive_items()
	update_active_items()
	PlayerManager.player.menu_opened = false
	get_tree().paused=false
	queue_free()
	return

func _unhandled_input(_event):
	if _event.is_action_pressed("menu"):
		close_menu()
	
