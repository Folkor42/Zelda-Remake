class_name GelDestroy extends EnemyState

const PICKUP = preload("res://Items/Item Pickup/item_pickup.tscn")
const DEATH_ANIM = preload("res://Scenes/enemy_death.tscn")

@export_category("Item Drops")
@export var drop_table : DropTable

var _direction : Vector2
var _damage_position : Vector2

func init() -> void:
	enemy.Enemy_Destroyed.connect( _on_enemy_destroyed )
	pass # Replace with function body.

func enter() -> void:
	enemy.invulnerable = true
	enemy.velocity = Vector2.ZERO
	var death = DEATH_ANIM.instantiate()
	death.position=enemy.position
	enemy.get_parent().call_deferred( "add_child", death )
	await get_tree().create_timer(0.2).timeout
	drop_items()
	enemy.queue_free()
	pass
	
func _on_enemy_destroyed ( hurt_box : HurtBox ) -> void:
	state_machine.ChangeState( self )
	
func drop_items() -> void:
	var turn_drop = drop_table.get_drop(PlayerManager.kill_count)
	PlayerManager.increase_kill_counter()
	if turn_drop:
		var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
		drop.item_data = turn_drop
		print (drop.item_data.name)
		enemy.get_parent().add_child( drop )
		drop.global_position = enemy.global_position
		drop.velocity = enemy.velocity.rotated( randf_range(-1.5, 1.5) ) * randf_range( 0.9, 1.5)
		drop.bounce()
		drop.start_timer()
	pass
