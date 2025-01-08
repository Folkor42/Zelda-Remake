class_name AquamentusStateStun extends DungeonEnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 100.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : DungeonEnemyState

var _animation_finished : bool = false
var _damage_position : Vector2

func init() -> void:
	enemy.Enemy_Damaged.connect( _on_enemy_damaged )
	pass # Replace with function body.

func _on_enemy_damaged ( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity,1.0,0.0,1.0)

func SetShader_BlinkIntensity( newvalue : float) -> void:
	$"../../Sprite2D".material.set_shader_parameter("blink_intensity", newvalue)	
	pass		
	
func _on_animation_finished ( _a : String ) -> void:
	_animation_finished = true
