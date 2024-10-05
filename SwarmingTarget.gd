class_name SwarmingTarget extends Area2D

signal swarming_target_clicked(target: SwarmingTarget)
signal swarming_target_populated(amount: int)
signal swarming_target_cleared
signal swarming_target_activated
signal swarming_target_deactivated
signal fly_popped

@export
var fly_target_min_count = 1
@export
var fly_target_max_count = 1

var flies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("input_event", self._on_input_event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_fly(fly: Firefly) -> void:
	if flies.has(fly):
		print("Fly already in target! This should NOT happen!")
		return
	
	var prev_count = len(flies)
	flies.append(fly)
	fly.set_parent(self)
	var new_count = prev_count + 1
	print("Target got a fly added, flies now: %d" % new_count)
	emit_signal("swarming_target_populated", new_count)
	
	if new_count >= fly_target_min_count and new_count <= fly_target_max_count:
		emit_signal("swarming_target_activated")
	elif prev_count >= fly_target_min_count and prev_count <= fly_target_max_count:
		emit_signal("swarming_target_deactivated")

func remove_flies() -> void:
	await get_tree().create_timer(1.5).timeout
	var fly_count = len(flies)
	for i in range(0, fly_count):
		var timer = get_tree().create_timer(i * 0.1)
		await timer.timeout
		remove_fly()


func remove_fly() -> void:
	print("Removing fly from target")
	var prev_count = len(flies)
	if prev_count == 0:
		print("Fly count was zero, cannot remove a fly")
		return
	
	var fly = flies.pop_back()
	var new_count = prev_count - 1
	emit_signal("fly_popped", fly)
	
	if new_count >= fly_target_min_count and new_count <= fly_target_max_count:
		emit_signal("swarming_target_activated")
	elif prev_count >= fly_target_min_count and prev_count <= fly_target_max_count:
		emit_signal("swarming_target_deactivated")
	
	if new_count == 0:
		emit_signal("swarming_target_cleared")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Left clicked")
			emit_signal("swarming_target_clicked", self)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("Right clicked, fly count: %d" % len(flies))
			remove_fly()
