extends Area2D

signal fly_aqcuired

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Firefly:
		if area.free_fly:
			print("Found a free fly!")
			var swarm = get_parent() as Swarm
			swarm.flies.append(area)
			area.set_parent(swarm)
			area.free_fly = false
			emit_signal("fly_aqcuired")
