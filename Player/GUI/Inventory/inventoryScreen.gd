extends CanvasLayer

@onready var button: Button = $Control/Button
@onready var button_2: Button = $Control/Button2
@onready var button_3: Button = $Control/Button3
@onready var button_4: Button = $Control/Button4
@onready var button_5: Button = $Control/Button5
@onready var button_6: Button = $Control/Button6
@onready var button_7: Button = $Control/Button7
@onready var button_8: Button = $Control/Button8

@onready var selected_item_sprite: Sprite2D = $Control/SelectedItemSprite
@onready var boomerang_sprite: Sprite2D = $Control/Button/BoomerangSprite
@onready var bomb_sprite: Sprite2D = $Control/Button2/BombSprite
@onready var arrow_sprite: Sprite2D = $Control/Button3/ArrowSprite
@onready var bow_sprite: Sprite2D = $Control/Button3/BowSprite
@onready var candle_sprite: Sprite2D = $Control/Button4/CandleSprite
@onready var flute_sprite: Sprite2D = $Control/Button5/FluteSprite
@onready var bait_sprite: Sprite2D = $Control/Button6/BaitSprite
@onready var potion_sprite: Sprite2D = $Control/Button7/PotionSprite
@onready var wand_sprite: Sprite2D = $Control/Button8/WandSprite




func _ready() -> void:
	$Control/Button.grab_focus()
	
	button.pressed.connect(equip.bind("Boomerang"))
	
	if PlayerManager.bombs>0:
		button_2.pressed.connect(equip.bind("Bomb"))
		bomb_sprite.visible=true
	else:
		bomb_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("Bow"):
		button_3.pressed.connect(equip.bind("Bow"))
		bow_sprite.visible=true
		if PlayerManager.inventory.contents.has("Arrows"):
			arrow_sprite.visible=true
		else:
			arrow_sprite.visible=false
	else:
		bow_sprite.visible=false
	
	if PlayerManager.inventory.contents.has("Blue Candle") or PlayerManager.inventory.contents.has("Red Candle"):
		button_4.pressed.connect(equip.bind("Candle"))
		candle_sprite.visible=true
	else:
		candle_sprite.visible=false
		
	button_5.pressed.connect(equip.bind("Flute"))
	button_6.pressed.connect(equip.bind("Bait"))
	
	if PlayerManager.inventory.contents.has("Red Potion") or PlayerManager.inventory.contents.has("Blue Potion"):
		button_7.pressed.connect(equip.bind("Potion"))
		potion_sprite.visible=true
	else:
		potion_sprite.visible=false
	
	button_8.pressed.connect(equip.bind("Wand"))
	
	
func equip (item:String)->void:
	print("equipping")
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
