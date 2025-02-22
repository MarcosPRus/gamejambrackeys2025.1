extends Control

var writing_speed : float = 500.0 # In letters/second
var tween

@onready var MainScreenText := $MainScreenContainer/MainScreenText
@onready var SecondaryScreenText := $SecondaryScreenContainer/SecondaryScreenText
@onready var ShipIntegrityProgressBar := $TextureProgressBar

signal writing_finished


func _ready() -> void:
	Global.GUI = self

func _process(delta: float) -> void:
	ShipIntegrityProgressBar.value = Global.ship_integrity


func clear_main_screen() -> void:
	MainScreenText.text = ""

#func set_main_screen_text(new_text:String) -> void:
	#if tween:
		#tween.kill()
	#tween = create_tween()
	#Global.main_screen_tween = tween
	#tween.tween_method(animate_main_text, "", new_text, new_text.length()/writing_speed)

func append_main_screen_text(new_text: String) -> void:
	var text_length = new_text.length()
	for i in text_length:
		MainScreenText.append_text(new_text[i])
		if !$AudioStreamPlayer.playing:
			$AudioStreamPlayer.pitch_scale = randf_range(0.5, 1.5)
			$AudioStreamPlayer.play()
		await get_tree().create_timer(1/writing_speed).timeout
	writing_finished.emit()

func set_secondary_screen_text(new_text:String) -> void:
	SecondaryScreenText.text = new_text

func append_task(task:String) -> void:
	SecondaryScreenText.append_text(task)

#func animate_main_text(new_text:String) -> void:
	#$MainScreenText.text = new_text


func drop_panel() -> void:
	var breakable_panels: Array[Node]
	
	for panel in get_children():
		if panel.is_in_group("breakable_panels"):
			breakable_panels.append(panel)
			
	breakable_panels[randi_range(0,breakable_panels.size()-1)].broken = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.SprinklerSystem.start_sprinklers()
		await get_tree().create_timer(5).timeout
		$SprinklersButton/VBoxContainer/CheckButton.button_pressed = false
	else:
		Global.SprinklerSystem.stop_sprinklers()

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

###########################
## Subspace Warp signals ##
###########################
func _on_subspace_warp_engage_pressed() -> void:
	Global.action_pressed = "Engage Subspace Warp"

func _on_subspace_warp_disengage_pressed() -> void:
	Global.action_pressed = "Disengage Subspace Warp"

func _on_subspace_warp_factor_drag_ended(value_changed: bool) -> void:
	Global.action_pressed = "Set Subspace Warp Factor to " + str($SubspaceWarp/VBoxContainer/HBoxContainer/Factor.value)

################################
## Zero-point Emitter signals ##
################################
func _on_zpe_tune_pressed() -> void:
	Global.action_pressed = "Tune the Zero-Point Emitter"

func _on_zpe_sensitivity_drag_ended(value_changed: bool) -> void:
	Global.action_pressed = "Modulate the Zero-Point Emitter Sensitivity to " + str($ZeroPointEmitter/VBoxContainer/HBoxContainer/Sensitivity.value)
