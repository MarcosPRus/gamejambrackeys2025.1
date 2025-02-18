extends Node

var GUI : Control

var task_count : int = 0
var current_task_sequence : Array[String] = []
var current_task_index : int = 0

var action_pressed : String:
	set(value):
		action_pressed = value
		check_action_pressed()

var tasks_list : Array[String] = [
	"Open the Cryogenic Valve",
	"Close the Cryogenic Valve",
	"Adjust Cryogenic Valve Flow to XXX",
	
	"Revert the Flux Capacitor",
	"Calibrate the Flux Capacitor",
	"Override the Flux Capacitor",
	
	"Activate the Neutron Oscillator",
	"Deactivate the Neutron Oscillator",
	"Adjust Neutron Oscillator Frequency to XXX",
	
	#"Engage Subspace Warp",
	#"Disengage Subspace Warp",
	#"Set Subspace Warp Factor to XXX",
	
	#"Tune the Zero-Point Emitter",
	#"Modulate the Zero-Point Emitter Sensitivity to XXX"
]

# Define the game phases
enum GameState {
	START,
	MICROMETEORS,
	REACTOR_OVERHEAT,
	ENGINE_LOSS,
	SOLAR_STORM,
	MISSION_COMPLETE
}
var current_state = GameState.START


func _ready() -> void:
	randomize() # Seed the random number generator
	await get_tree().create_timer(0.1).timeout
	change_state(GameState.START)


func change_state(new_state: int) -> void:
	# TODO: Clean up the previous state
	action_pressed = ""
	current_task_sequence = []
	current_task_index = 0
	GUI.set_secondary_screen_text("")
	
	current_state = new_state
	
	match current_state:
		GameState.START:
			start_state()
		GameState.MICROMETEORS:
			micrometeors_state()
		GameState.REACTOR_OVERHEAT:
			reactor_oh_state()
		GameState.ENGINE_LOSS:
			engine_loss_state()
		GameState.SOLAR_STORM:
			solar_storm_state()
		GameState.MISSION_COMPLETE:
			mission_complete_state()


func start_state() -> void:
	print("Start state entered")
	GUI.set_main_screen_text("Good morning, Commander!                   
Today is the final day of our expedition.                   
As always, everything is running perfectly.                   
We are scheduled to arrive at the destination in just a few hours.             
Congratulations on another flawlessly succesful mission!                   
I've reviewed all the ship systems and identified a few minor parameters that need a quick adjustment to maintain our pristine operational status.                   

Please complete the tasks displayed in the right panel [color=#FF004D]in the correct order[/color].")
	
	await get_tree().create_timer(1).timeout # TODO: Poner a 30 en la versión final
	
	task_count = 3
	setup_tasks_sequence()


func micrometeors_state() -> void:
	print("Micrometeors state entered")
	GUI.set_main_screen_text("Great job commander!                                         
What is that sound?                
Oh! looks like some meteorites are impacting the ship.           
There is no need to worry, we just need to increase the shields power")

	await get_tree().create_timer(1).timeout # TODO: Poner a 30 en la versión final
	
	task_count = 5
	setup_tasks_sequence()


func reactor_oh_state() -> void:
	print("Reactor overheat state entered")
	GUI.set_main_screen_text("Ups, now the reactor is over heating")

	await get_tree().create_timer(1).timeout # TODO: Poner a 30 en la versión final
	
	task_count = 10
	setup_tasks_sequence()


func engine_loss_state() -> void:
	pass


func solar_storm_state() -> void:
	pass


func mission_complete_state() -> void:
	pass


func setup_tasks_sequence() -> void:
	current_task_index = 0
	var tasks_pool := tasks_list.duplicate()
	tasks_pool.shuffle()
	current_task_sequence = tasks_pool.slice(0, task_count)
	
	for i in current_task_sequence.size():
		current_task_sequence[i] = current_task_sequence[i].replace("XXX", str(randi_range(0,4)))
		GUI.append_task("[color=#FF004D]" + str(i+1) + ". " + current_task_sequence[i] + "[/color]")
		GUI.append_task("

")

func update_tasks_sequence() -> void:
	GUI.set_secondary_screen_text("")
	for i in current_task_sequence.size():
		if i < current_task_index:
			GUI.append_task("[color=green]" + str(i+1) + ". " + current_task_sequence[i] + "[/color]")
		else:
			GUI.append_task("[color=#FF004D]" + str(i+1) + ". " + current_task_sequence[i] + "[/color]")
		GUI.append_task("

")


func check_action_pressed():
	if current_task_sequence != [] && current_task_index < current_task_sequence.size():
		if action_pressed == current_task_sequence[current_task_index]:
			current_task_index += 1
			if current_task_index >= task_count:
				change_state(current_state+1)
			else:
				update_tasks_sequence()
				print("Action pressed: " + action_pressed)
				print("Next task: " + current_task_sequence[current_task_index])
				#print(current_task_index)
