extends Sprite2D


func _process(delta: float) -> void:
	var i = randf()
	if i < 0.01:
		modulate = Color(2, 0, 0.6)
	else:
		modulate = Color(0, 1.79, 0.42)



func set_led_color(color : String) -> void:
	if color == "red":
		modulate = Color(2, 0, 0.6)
	elif color == "green":
		modulate = Color(0, 1.79, 0.42)
