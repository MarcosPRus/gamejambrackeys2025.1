extends Node2D

@export var noise : NoiseTexture2D
var time_passed := 0.0


func _ready() -> void:
	$Console/Led.set_led_color("green")
	$Console/Led2.set_led_color("green")
	$Console/Led3.set_led_color("red")


func _process(delta: float) -> void:
#region Blink Lights Glow
	time_passed += delta
	
	var sampled_noise = noise.noise.get_noise_1d(time_passed)
	sampled_noise = abs(sampled_noise)
	
	$WorldEnvironment.environment.glow_intensity = (sampled_noise+1)/2.5
#endregion
