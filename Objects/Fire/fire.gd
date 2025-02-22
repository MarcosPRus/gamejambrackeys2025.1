extends GPUParticles2D

var extinguishing: bool = false

func _process(delta: float) -> void:
	if Global.SprinklerSystem.sprinklers_on and !extinguishing:
		extinguish()
	
	#print(modulate.a)


func extinguish() -> void:
	emitting = false
	await get_tree().create_timer(10).timeout
	queue_free()
	#extinguishing = true
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "modulate.a", 0.0, 5)
	#print("EXTINGUISH MEE")
