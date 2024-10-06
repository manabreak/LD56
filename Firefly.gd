class_name Firefly extends Node2D

var fly_center: Vector2 = Vector2()
var fly_direction: Vector2 = Vector2(0, 0)
var fly_angle = 0
var fly_timer = 0.0
var rot_direction = 1.0
var rot_speed = 1.0
var fly_speed = 16.0
var sc_multip = 2.0
var migrating = false
var migration_source_point = Vector2()

func set_parent(p: Node2D) -> void:
	# fly_center = p.position
	reparent(p, true)
	print("Fly at " + str(position) + ", target at " + str(fly_center))
	migrating = true
	migration_source_point = position


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fly_angle = randf_range(0, PI * 2)
	fly_direction = Vector2.from_angle(fly_angle)
	rot_direction = signf(randf_range(-1, 1))
	rot_speed = randf_range(1.0, 5.0)
	fly_speed = randf_range(5.0, 8.0)
	sc_multip = randf_range(1.0, 2.0)
	fly_timer = randf()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if migrating:
		position = lerp(position, Vector2(0, 0), delta * 4.0)
		if (fly_center - position).length() < 16.0:
			migrating = false
			fly_angle = position.angle()
			fly_direction = Vector2.from_angle(fly_angle)
	else:
		fly_direction = fly_direction.rotated(delta * rot_speed * rot_direction)
		fly_timer += delta
		var s = sin(fly_timer)
		var c = cos(fly_timer)
	
		position = fly_center + fly_direction * fly_speed * Vector2(s * sc_multip, c * sc_multip)
