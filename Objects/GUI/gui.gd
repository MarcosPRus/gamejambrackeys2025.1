extends Control

var writing_speed : float = 150.0 # In letters/second
var tween

signal writing_finished


func _ready() -> void:
	Global.GUI = self


func clear_main_screen() -> void:
	$MainScreenText.text = ""

#func set_main_screen_text(new_text:String) -> void:
	#if tween:
		#tween.kill()
	#tween = create_tween()
	#Global.main_screen_tween = tween
	#tween.tween_method(animate_main_text, "", new_text, new_text.length()/writing_speed)

func append_main_screen_text(new_text: String) -> void:
	var text_length = new_text.length()
	for i in text_length:
		$MainScreenText.append_text(new_text[i])
		await get_tree().create_timer(1/writing_speed).timeout
	writing_finished.emit()

func set_secondary_screen_text(new_text:String) -> void:
	$SecondaryScreenText.text = new_text

func append_task(task:String) -> void:
	$SecondaryScreenText.append_text(task)

#func animate_main_text(new_text:String) -> void:
	#$MainScreenText.text = new_text


############################
## Flux capacitor signals ##
############################
func _on_flux_capacitor_calibrate_pressed() -> void:
	Global.action_pressed = "Calibrate the Flux Capacitor"

func _on_flux_capacitor_revert_pressed() -> void:
	Global.action_pressed = "Revert the Flux Capacitor"

func _on_flux_capacitor_override_pressed() -> void:
	Global.action_pressed = "Override the Flux Capacitor"

#############################
## Cryogenic valve signals ##
#############################
func _on_cryogenic_valve_open_pressed() -> void:
	Global.action_pressed = "Open the Cryogenic Valve"

func _on_cryogenic_valve_close_pressed() -> void:
	Global.action_pressed = "Close the Cryogenic Valve"

func _on_adjust_cryogenic_valve_flow_drag_ended(value_changed: bool) -> void:
	Global.action_pressed = "Adjust Cryogenic Valve Flow to " + str($CryogenicValve/VBoxContainer/HBoxContainer/AdjustFlow.value)

################################
## Neutron Oscillator signals ##
################################
func _on_neutron_oscillator_activate_pressed() -> void:
	Global.action_pressed = "Activate the Neutron Oscillator"

func _on_neutron_oscillator_deactivate_pressed() -> void:
	Global.action_pressed = "Deactivate the Neutron Oscillator"

func _on_adjust_neutron_oscillator_frequency_drag_ended(value_changed: bool) -> void:
	Global.action_pressed = "Adjust Neutron Oscillator Frequency to " + str($NeutronOscillator/VBoxContainer/HBoxContainer/AdjustFrequency.value)
