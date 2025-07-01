class_name GoriyaAttack extends EnemyState

const ENEMYBULLET = preload("res://Dungeons/Enemies/Goriya/Boomerang.tscn")

@export var after_attack_state : EnemyState

var next_state : EnemyState = null

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	next_state = null
	if !enemy.throw_swords:
		next_state = next_state
	throw_sword()
	pass
	
func exit() -> void:
	pass

func process( _delta : float ) -> EnemyState:
	return next_state

func physics( _delta : float ) -> EnemyState:
	return null

func throw_sword()->void:
	var pos = enemy.global_position
	var rot = enemy.rotation
	if enemy.current_direction==Vector2.UP:
		rot = deg_to_rad(270)
	elif enemy.current_direction==Vector2.DOWN:
		rot = deg_to_rad(90)
	elif enemy.current_direction==Vector2.RIGHT:
		rot = deg_to_rad(0)
	elif enemy.current_direction==Vector2.LEFT:
		rot = deg_to_rad(180)
	_on_enemy_shoot( pos, rot)
	pass
	
func _on_enemy_shoot( pos,rot):
	var bullet = ENEMYBULLET.instantiate()
	bullet.position = pos
	bullet.rotation = rot
	bullet.direction=enemy.current_direction
	enemy.add_child (bullet)
	next_state=after_attack_state
	pass
