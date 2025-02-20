extends Camera2D

var shaking: bool = false
var on_cooldown: bool = false

var intensity: int = 0


func _process(delta: float) -> void:
	if shaking:
		offset = Vector2(randi_range(0,intensity), randi_range(0, intensity))


func shake(amount: int, duration: float) -> void:
	shaking = true
	var timer = get_tree().create_timer(duration)
	timer.timeout.connect(on_shaking_timeout)
	intensity = amount


func on_shaking_timeout() -> void:
	shaking = false
	on_cooldown = true
	offset = Vector2.ZERO
	var timer = get_tree().create_timer(randf_range(2,4))
	timer.timeout.connect(on_cooldown_timeout)

func on_cooldown_timeout() -> void:
	on_cooldown = false
