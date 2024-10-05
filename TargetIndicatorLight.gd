extends PointLight2D

@onready
var target_energy = energy

@onready
var tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("swarming_target_activated", self._on_activate)
	get_parent().connect("swarming_target_deactivated", self._on_deactivate)
	energy = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_activate():
	tween.stop()
	tween = create_tween()
	tween.tween_property(self, "energy", target_energy, 1.0)

func _on_deactivate():
	tween.stop()
	tween = create_tween()
	tween.tween_property(self, "energy", 0.0, 0.5)
