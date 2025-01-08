class_name BombHitBox extends Area2D

signal Damaged( hurt_box : HurtBox )

func _ready():
	pass
	
func _process( _delta ):
	pass
	
func TakeDamage ( hurt_box : HurtBox ) -> void:
	print ("BOOM!!!")
	Damaged.emit( hurt_box )
