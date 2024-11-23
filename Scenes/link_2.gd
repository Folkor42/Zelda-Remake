extends CharacterBody2D

@export var speed : int = 120
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var sword: Sprite2D = $Sword
@onready var hurt_box: HurtBox = $Sword/HurtBox

var cardinal_direction : Vector2 = Vector2.DOWN

func get_input():
	var input_direction = Vector2(Input.get_axis("move_left","move_right"),	Input.get_axis("move_up","move_down")).normalized()
	velocity = input_direction * speed
	sword.scale.x = 1
	sprite.scale.x = 1
	
	if input_direction==Vector2(0, 1):
		sword.visible=false
		hurt_box.monitoring=false
		animation_player.play("walk_down")
		cardinal_direction = Vector2.DOWN
	elif input_direction==Vector2(0, -1):
		sword.visible=false
		hurt_box.monitoring=false
		animation_player.play("walk_up")
		cardinal_direction = Vector2.UP
	elif input_direction==Vector2(-1, 0):
		sprite.scale.x = -1
		sword.scale.x = -1
		sword.visible=false
		hurt_box.monitoring=false
		animation_player.play("walk_side")
		cardinal_direction = Vector2.LEFT
	elif input_direction==Vector2(1, 0):
		sword.visible=false
		hurt_box.monitoring=false
		animation_player.play("walk_side")
		cardinal_direction = Vector2.RIGHT
	else:
		if cardinal_direction==Vector2.UP:
			if Input.is_action_pressed("attack"):
				animation_player.play("attack_up")
				sword.visible=true
				hurt_box.monitoring=true
			else:
				sword.visible=false
				hurt_box.monitoring=false
				animation_player.play("idle_up")
		elif cardinal_direction==Vector2.DOWN:
			if Input.is_action_pressed("attack"):
				animation_player.play("attack_down")
				sword.visible=true
				hurt_box.monitoring=true
			else:
				sword.visible=false
				hurt_box.monitoring=false
				animation_player.play("idle_down")
		elif cardinal_direction==Vector2.RIGHT:
			sprite.scale.x = 1
			if Input.is_action_pressed("attack"):
				animation_player.play("attack_right")
				sword.visible=true
				hurt_box.monitoring=true
			else:
				sword.visible=false
				hurt_box.monitoring=false
				animation_player.play("idle_side")
		elif cardinal_direction==Vector2.LEFT:
			sprite.scale.x = -1
			sword.scale.x = -1
			if Input.is_action_pressed("attack"):
				animation_player.play("attack_left")
				sword.visible=true
				hurt_box.monitoring=true
			else:
				sword.visible=false
				hurt_box.monitoring=false
				animation_player.play("idle_side")


func _physics_process(_delta):
	get_input()
	move_and_slide()
