extends Node

const DIR_BREAKING = 0.97
const FLY_SPEED = 200.0
const DECELERATION = 0.93

@onready
var swarm: Swarm

var input_vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swarm = get_parent() as Swarm


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if len(swarm.flies) == 0:
		swarm.linear_velocity *= DECELERATION
		return
	
	if Input.is_action_pressed("move_left"):
		input_vel.x -= 1.0 * delta
	elif input_vel.x < 0.0:
		input_vel.x *= DIR_BREAKING
	if Input.is_action_pressed("move_right"):
		input_vel.x += 1.0 * delta
	elif input_vel.x > 0.0:
		input_vel.x *= DIR_BREAKING
	if Input.is_action_pressed("move_up"):
		input_vel.y -= 1.0 * delta
	elif input_vel.y < 0.0:
		input_vel.y *= DIR_BREAKING
	if Input.is_action_pressed("move_down"):
		input_vel.y += 1.0 * delta
	elif input_vel.y > 0.0:
		input_vel.y *= DIR_BREAKING
	
	
	if input_vel.length_squared() > 1.0:
		input_vel = input_vel.normalized()
	
	if not input_vel.is_zero_approx():
		swarm.linear_velocity = input_vel * FLY_SPEED
	else:
		swarm.linear_velocity *= DECELERATION
