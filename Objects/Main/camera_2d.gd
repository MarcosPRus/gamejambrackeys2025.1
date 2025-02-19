extends Camera2D

var shaking: bool = false
var intensity: int = 0

func _ready() -> void:
	Global.Camera = self


func _process(delta: float) -> void:
	if shaking:
		offset = Vector2(randi_range(0,intensity), randi_range(0, intensity))


func shake(amount: int, duration: float) -> void:
	shaking = true
	var timer = get_tree().create_timer(duration)
	timer.timeout.connect(on_timer_timeout)
	intensity = amount


func on_timer_timeout() -> void:
	shaking = false
	offset = Vector2.ZERO
	await get_tree().create_timer(randf_range(1.5,4)).timeout
	Global.crisis_mode = true
