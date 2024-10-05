extends Area2D

var tween = create_tween()
var fly_counter = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Firefly and area.free_fly:
		fly_counter += 1
		if fly_counter == 1:
			tween.stop()
			tween = create_tween()
			tween.tween_property($Halo, "modulate:a", 0.15, 1.0)


func _on_area_exited(area: Area2D) -> void:
	if area is Firefly and area.free_fly:
		fly_counter -= 1
		if fly_counter < 0:
			fly_counter == 0
		if fly_counter == 0:
			tween.stop()
			tween = create_tween()
			tween.tween_property($Halo, "modulate:a", 0.0, 1.0)


func _fly_aqcuired() -> void:
	fly_counter -= 1
	if fly_counter < 0:
		fly_counter == 0
	print("Fly acquired, flies in radar now: %d" % fly_counter)
	if fly_counter == 0:
		tween.stop()
		tween = create_tween()
		tween.tween_property($Halo, "modulate:a", 0.0, 1.0)
