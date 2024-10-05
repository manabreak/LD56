extends TileMapLayer

@export
var targets: Array[SwarmingTarget] = []

@onready
var threshold = len(targets)

var activated_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for t in targets:
		t.connect("swarming_target_activated", self._on_swarming_target_activated)
		t.connect("swarming_target_deactivated", self._on_swarming_target_deactivated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_swarming_target_activated() -> void:
	activated_count += 1
	if activated_count >= threshold:
		queue_free()
		for t in targets:
			t.remove_flies()


func _on_swarming_target_deactivated() -> void:
	activated_count -= 1
