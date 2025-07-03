class_name Moldorm extends Enemy

const SEGMENT = preload("res://Dungeons/Enemies/Moldorm/segment.tscn")
@onready var hit_box: HitBox = $HitBox
const NES_SPRITE = preload("res://Dungeons/Enemies/NES - The Legend of Zelda - Dungeon Enemies.png")
const SNES_SPRITE = preload("res://Dungeons/Enemies/SNES - Dungeon Enemies.png")

var segments := [] # Array of segment nodes
var total_segments := 4
var direction := Vector2.RIGHT # Or any initial 8-direction
var active : bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var wall_detector: RayCast2D = $WallDetector

func take_damage(_hb:HurtBox):
	var amount: int = _hb.damage
	for i in range(amount):
		if segments.size() > 1:
			var last_segment = segments.pop_back()
			last_segment.modulate = Color(1, 0.5, 0.5)  # Red flash
			last_segment.queue_free()
		else:
			var last_segment = segments.pop_back()
			last_segment.queue_free()
			die()
			return
	if get_parent().has_signal("activate"):
		get_parent().activate.connect(activate)
	else:
		get_parent().get_parent().activate.connect(activate)
	if get_parent().has_signal("deactivate"):
		get_parent().deactivate.connect(deactivate)
	else:
		get_parent().get_parent().deactivate.connect(deactivate)

func activate ()->void:
	active = true
	
func deactivate ()->void:
	active = false

func die():
	# Add explosion effect, sound, etc. here
	queue_free()

func _ready():
	hit_box.Damaged.connect(take_damage)
	Events.toggle_graphics.connect(toggle_graphics)
	toggle_graphics(PlayerManager.upgraded_graphics)
	for i in range(total_segments):
		var seg = SEGMENT.instantiate()
		seg.global_position=global_position
		get_parent().call_deferred("add_child",seg)
		seg.Damaged.connect(take_damage)
		segments.append(seg)
		if i > 0:
			segments[i].follow_target = segments[i-1]
		elif i == 0:
			segments[i].follow_target = self
			
func _process(delta):
	move_and_bounce(delta)
	
	
func move_and_bounce(delta):
	if active:
		var motion = direction.normalized() * speed * delta
		global_position += motion

		# Simple bounce on screen bounds
		#if global_position.x < 100 or global_position.x > 200:
			#direction.x *= -1
		#if global_position.y < 100 or global_position.y > 200:
			#direction.y *= -1

		# Optional: randomly change direction sometimes
		if randi() % 100 < 2 or wall_detector.is_colliding():
			randomize_direction()
			update_ray_direction()

func update_ray_direction():
	var ray_length := 16  # or whatever you want
	wall_detector.target_position = direction.normalized() * ray_length
		
func update_segments(delta : float):
	for i in range(1, segments.size()):
		var leader = segments[i - 1]
		var follower = segments[i]
		var to_leader = leader.global_position - follower.global_position
		follower.global_position += to_leader.normalized() * speed * 0.8 * delta

func randomize_direction():
	var cardinal_dirs = {
		Vector2(1, 0): [Vector2(1, -1), Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(0, -1)],        # Right
		Vector2(1, 1): [Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(0, 0)],                         # Down-Right
		Vector2(0, 1): [Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1), Vector2(1, 0), Vector2(-1, 0)],        # Down
		Vector2(-1, 1): [Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(0, 0)],                      # Down-Left
		Vector2(-1, 0): [Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, -1), Vector2(0, 1), Vector2(0, -1)],    # Left
		Vector2(-1, -1): [Vector2(-1, 0), Vector2(-1, -1), Vector2(0, -1), Vector2(0, 0)],                   # Up-Left
		Vector2(0, -1): [Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1), Vector2(-1, 0), Vector2(1, 0)],    # Up
		Vector2(1, -1): [Vector2(0, -1), Vector2(1, -1), Vector2(1, 0), Vector2(0, 0)]                       # Up-Right
	}

	# Snap current direction to one of 8 canonical directions
	var snapped_dir = direction.round().clamp(Vector2(-1, -1), Vector2(1, 1))
	if snapped_dir == Vector2.ZERO:
		snapped_dir = Vector2(1, 0)  # Default direction if somehow stopped

	var options = cardinal_dirs.get(snapped_dir, [snapped_dir])
	
	# Build a weighted list: more likely to stay straight or turn gently
	var weighted = []
	for i in options.size():
		var weight = options.size() - i
		for j in range(weight):
			weighted.append(options[i].normalized())

	direction = weighted[randi() % weighted.size()]

func toggle_graphics( _new_value : bool )->void:
	if _new_value:
		sprite.texture=SNES_SPRITE
	else:
		sprite.texture=NES_SPRITE
