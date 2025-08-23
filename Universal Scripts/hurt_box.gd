class_name HurtBox extends Area2D

@export var damage : int = 1

signal hit
signal stun

func _ready():
	area_entered.connect( AreaEntered )
	pass
	
func AreaEntered( a : Area2D ) -> void:
	if a is HitBox:
		hit.emit()
		a.TakeDamage ( self )
	elif a is StunBox:
		#print ("STUNNING!")
		stun.emit()
		a.TakeDamage ()
	pass
