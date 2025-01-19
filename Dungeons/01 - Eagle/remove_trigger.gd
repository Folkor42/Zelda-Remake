class_name RemoveTrigger extends Node2D

var item_count : int = 0

signal cleared
signal enemies_defeated

func _ready() -> void:
	get_parent().activate.connect(player_entered)
	get_parent().deactivate.connect(player_exited)
	
func player_exited()->void:
	if child_exiting_tree.is_connected( on_enemy_destroyed ):
		child_exiting_tree.disconnect( on_enemy_destroyed )
			
func player_entered()->void:	
	item_count=0
	for i in get_children():
		if i is not TriggerDoor:
			item_count += 1
	if item_count <=0:
		cleared.emit()
		return
	print (item_count)

	child_exiting_tree.connect( on_enemy_destroyed )
	print (enemy_count())

func item_leave( _c )->void:
	item_count -= 1
	print (item_count)
	if item_count <= 0:
		print ("All Removed")
		cleared.emit()
		Events.secret_found()
	
func on_enemy_destroyed ( _e : Node2D ) -> void:
	if _e is Enemy or _e is DungeonEnemy:
		if enemy_count() <= 1:
			print("Enemy Defeated")
			enemies_defeated.emit()
			cleared.emit()
	pass
	
func enemy_count () -> int:
	var _count : int = 0
	for c in get_children():
		if c is Enemy or c is DungeonEnemy:
			_count += 1
	return _count
