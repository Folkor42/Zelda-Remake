extends CharacterBody2D

@export var speed : int = 120
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var run_sprite = $RunSprite

var cardinal_direction : Vector2 = Vector2.DOWN

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	run_sprite.scale.x = 1
	if input_direction==Vector2(0, 1):
		animation_player.play("walk_down")
		cardinal_direction = Vector2.DOWN
	elif input_direction==Vector2(0, -1):
		animation_player.play("walk_up")
		cardinal_direction = Vector2.UP
	elif input_direction==Vector2(-1, 0):
		run_sprite.scale.x = -1
		animation_player.play("walk_side")
		cardinal_direction = Vector2.LEFT
	elif input_direction==Vector2(1, 0):
		animation_player.play("walk_side")
		cardinal_direction = Vector2.RIGHT
	else:
		if cardinal_direction==Vector2.UP:
			animation_player.play("idle_up")
		elif cardinal_direction==Vector2.DOWN:
			animation_player.play("idle_down")
		elif cardinal_direction==Vector2.RIGHT:
			animation_player.play("idle_side")
			sprite.scale.x = 1
		elif cardinal_direction==Vector2.LEFT:
			sprite.scale.x = -1
			animation_player.play("idle_side")

func _physics_process(delta):
	get_input()
	move_and_slide()
