extends Node

@onready var item_bet_1: ItemBet = $ItemBet1
@onready var item_bet_2: ItemBet = $ItemBet2
@onready var item_bet_3: ItemBet = $ItemBet3
@onready var speaker: Label = $"../Label"

var value1 : int = -10 
var value2 : int = -10 
var value3 : int = -10 
var game : Array [int] = []

func _ready() -> void:
	value1 = _set_rand_value(-10,-40)
	value3 = _set_rand_value(20,50)
	game.append(value1)
	game.append(value2)
	game.append(value3)
	game.shuffle()
	item_bet_1.result=game[0]
	item_bet_2.result=game[1]
	item_bet_3.result=game[2]
	item_bet_1.selected.connect (show_results)
	item_bet_2.selected.connect (show_results)
	item_bet_3.selected.connect (show_results)
	item_bet_1.broke.connect (too_broke)
	item_bet_2.broke.connect (too_broke)
	item_bet_3.broke.connect (too_broke)

func show_results()->void:
	print ("Showing Results")
	item_bet_1._update_result()
	item_bet_2._update_result()
	item_bet_3._update_result()

func too_broke()->void:
	speaker.text="You don't have enough Money"
	speaker.get_node("AnimationPlayer").play("RESET")
	speaker.get_node("AnimationPlayer").play("Show Text")
	item_bet_1._too_broke()
	item_bet_2._too_broke()
	item_bet_3._too_broke()

func _set_rand_value(one,two)->int:
	var result=randi_range(0,1)
	if result == 0:
		return one
	else:
		return two
	
