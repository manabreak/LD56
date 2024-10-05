extends Node2D

const BLINK_ON = 0.3
const BLINK_OFF = 0.3
const BLINK_DELAY = 1.0

@export
var pattern: Array[int] = []

var lights: Array[PointLight2D] = []
var index = 0
var timer = 0.0
var blink_flag = false
var blink_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		if c is PointLight2D:
			lights.append(c)
			c.enabled = false
	index = len(lights)
	next_blinker()

func next_blinker():
	index += 1
	if index >= len(lights):
		index = 0
	blink_flag = true
	timer = 0.0
	blink_counter = 0
	
	for i in range(0, pattern[index]):
		lights[index].enabled = true
		await get_tree().create_timer(BLINK_ON).timeout
		lights[index].enabled = false
		await get_tree().create_timer(BLINK_OFF).timeout
	
	await get_tree().create_timer(BLINK_DELAY).timeout
	next_blinker()
