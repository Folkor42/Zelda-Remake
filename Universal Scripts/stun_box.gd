class_name StunBox extends Area2D

signal Stunned ( stun_box : StunBox )

func _ready():
	pass
	
func _process( _delta ):
	pass
	
func TakeDamage ( ) -> void:
	print ("Ooof!!!")
	Stunned.emit( null )
