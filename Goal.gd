extends Area2D

var timer = 0.0
@onready
var tween = create_tween()

@onready
var label = $CenterContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.modulate.a = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	var s = sin(timer)
	$Sprite2D.modulate.a = 0.1 + abs(s) * 0.2


func _on_body_entered(body: Node2D) -> void:
	if body is Swarm:
		print("Swarm entered goal")
		var swarm = body as Swarm
		if len(swarm.flies) == 25:
			label.text = "You found all fireflies!\nThank you for playing!"
		else:
			var flies_left = 25 - len(swarm.flies)
			if flies_left == 1:
				label.text = "There is still one more firefly left."
			else:
				label.text = "There are still %d fireflies left." % flies_left
		tween.stop()
		tween = create_tween()
		tween.tween_property(label, "modulate:a", 1.0, 1.0)


func _on_body_exited(body: Node2D) -> void:
	if body is Swarm:
		print("Swarm exited goal")
		tween.stop()
		tween = create_tween()
		tween.tween_property(label, "modulate:a", 0.0, 1.0)
