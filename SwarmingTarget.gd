class_name SwarmingTarget extends Area2D

signal swarming_target_clicked(target: SwarmingTarget)
signal swarming_target_populated(amount: int)
signal swarming_target_cleared
signal swarming_target_activated
signal fly_popped

var flies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("input_event", self._on_input_event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_fly(fly: Firefly) -> void:
	flies.append(fly)
	fly.set_parent(self)
	print("Target got a fly added, flies now: %d" % len(flies))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Left clicked")
			emit_signal("swarming_target_clicked", self)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("Right clicked, fly count: %d" % len(flies))
			if len(flies) > 0:
				print("Popping a fly")
				var fly = flies.pop_back()
				emit_signal("fly_popped", fly)
