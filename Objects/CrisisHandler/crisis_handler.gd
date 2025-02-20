extends Node2D

var fire_scene = preload("res://Objects/Fire/fire.tscn")

@onready var Camera = $Camera2D
@onready var ExplosionSoundPlayer = $ExplosionSoundPlayer
@onready var AlarmSoundPlayer = $AlarmSoundPlayer
@onready var SprinklerSystem = $SprinklerSystem

var fire_chance: float = 0.001
var panel_drop_chance: float = 0.0005


func _process(delta: float) -> void:
	if Global.crisis_mode:
		if !AlarmSoundPlayer.playing:
			AlarmSoundPlayer.play()
		shake_camera()
		create_fires()
		drop_panels()
		Global.ship_integrity -= delta
	else:
		AlarmSoundPlayer.stop()



func shake_camera():
	if !Camera.shaking and !Camera.on_cooldown:
		Camera.shake(randi_range(2,8) * Global.crisis_level, randf_range(1.0, 3.0))
		ExplosionSoundPlayer.pitch_scale = randf_range(0.3, 1.8)
		ExplosionSoundPlayer.play()

func create_fires():
	if randf() < fire_chance * Global.crisis_level:
		var fire_instance = fire_scene.instantiate()
		fire_instance.global_position = Vector2(randi_range(0,1280), randi_range(0,720))
		get_tree().current_scene.add_child(fire_instance)
		
		SprinklerSystem.start_sprinklers()

func drop_panels():
	pass


func run_crisis_mode() -> void:
	var intensity: int = randi_range(10,40)
	var duration: float = randf_range(1.0, 3.0)
	Camera.shake(intensity, duration)
	Global.crisis_mode = false
	
	if randf() > 0.9:
		var fire_instance = fire_scene.instantiate()
		fire_instance.global_position = Vector2(randi_range(0,1280), randi_range(0,720))
		get_tree().current_scene.add_child(fire_instance)
