extends TileMapLayer

var activated_1 = false
var activated_2 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_swarming_target_2_swarming_target_activated() -> void:
	activated_1 = true
	if activated_2:
		queue_free()


func _on_swarming_target_3_swarming_target_activated() -> void:
	activated_2 = true
	if activated_1:
		queue_free()
