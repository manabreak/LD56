class_name Swarm extends RigidBody2D

@export
var swarming_targets: Node2D

var flies: Array[Firefly] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		if c is Firefly:
			flies.append(c)
			c.set_parent(self)
	print("Swarm ready with %d flies" % len(flies))
	
	for c in swarming_targets.get_children():
		c.connect("swarming_target_clicked", self._target_clicked)
		c.connect("fly_popped", self._fly_popped)


func _target_clicked(target: SwarmingTarget):
	print("Clicked target")
	if len(flies) > 1:
		fly_to_target(target)


func fly_to_target(target: SwarmingTarget) -> void:
	print("Flying a fly from swarm to target")
	var fly = flies.pop_back() as Firefly
	target.add_fly(fly)


func _fly_popped(fly: Firefly) -> void:
	print("Fly popped, adding back to swarm")
	fly.set_parent(self)
	flies.append(fly)
