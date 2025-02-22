extends Node

var GUI : Control
var SprinklerSystem : Node2D
var main_screen_tween : Tween

var crisis_mode : bool = false
var crisis_level : float = 1.0

var ship_integrity: float = 100.0

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
	
	"Engage Subspace Warp",
	"Disengage Subspace Warp",
	"Set Subspace Warp Factor to XXX",
	
	"Optimize the Tachyon Field",
	"Realign the Tachyon Field",
	"Deploy the Tachyon Field",
	
	"Refill the Antimatter Container",
	
	"Restore the Plasma Conduits",
	"Cool-down the Plasma Conduits",
	"Adjust the Plasma Conduits",
	"Turn off the Plasma Conduits",
	
	"Synchronize the Sub-Quantum Tunneling Optimizer",
	"Power Down the Sub-Quantum Tunneling Optimizer",
	"Adjust the Sub-Quantum Tunneling Optimizer Coefficient to XXX",
	"Set the Sub-Quantum Tunneling Optimizer Level to XXX",
	"Dial the Sub-Quantum Tunneling Optimizer Rate to XXX"
	
	
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

func wait(time: float, wait_writing: bool) -> void:
	if wait_writing:
		await GUI.writing_finished
	await get_tree().create_timer(time).timeout

func start_state() -> void:
	print("Start state entered")
	GUI.clear_main_screen()
	crisis_mode = false
	
	GUI.append_main_screen_text("Good morning, Commander!")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nToday is the final day of our expedition and everything is running perfectly.")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nAs you can see on the top-left bar, the ship integrity is at 100%.")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nWe are scheduled to arrive at the destination in just a few hours.")
	await wait(0.75, true)
	GUI.append_main_screen_text(" At this point in the mission, nothing can possibly go wrong, so congratulations on another flawlessly succesful mission!")
	await wait(1.5, true)
	GUI.append_main_screen_text("\n\nI've reviewed all the ship systems and identified a few minor parameters that need a quick adjustment to maintain our pristine operational status.")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nPlease complete the tasks displayed in the right panel in the correct order.")
	await wait(0, true)
	
	task_count = 3
	setup_tasks_sequence()


func micrometeors_state() -> void:
	print("Micrometeors state entered")
	GUI.clear_main_screen()
	
	GUI.append_main_screen_text("Excellent work, Commander!")
	await wait(2, true)
	GUI.clear_main_screen()
	
	crisis_level = 0.5
	crisis_mode = true
	await wait(1.5, false)
	
	GUI.append_main_screen_text("I am detecting a curious vibration on the ships hull")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nCould that be... meteorites?")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nNo problem at all, we just need to increase the shields power a bit and we'll deflect them effortlessly")
	await wait(1, true)
	
	task_count = 5
	GUI.append_main_screen_text("\n\nPlease complete the " + str(task_count) + " tasks displayed in the right panel in the correct order.")
	await wait(0, true)
	setup_tasks_sequence()


func reactor_oh_state() -> void:
	print("Reactor overheat state entered")
	crisis_mode = false
	GUI.clear_main_screen()
	
	GUI.append_main_screen_text("Great job avoiding that little crisis, Commander!")
	await wait(2, true)
	GUI.append_main_screen_text("\n\nLooks like some control panels have fallen and there are a few fires.")
	await wait(0.75, true)
	GUI.append_main_screen_text("\n\nNo need to worry! Just tap the fallen panels to fix them and press the fire extinguisher button to clear the fires.")
	await wait(3, true)
	
	crisis_mode = true
	crisis_level = 1.0
	await wait(1.5, false)
	
	GUI.clear_main_screen()
	GUI.append_main_screen_text("That sound again, what is it now?")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nIt appears that the shields are drawing a bit more energy than expected and the reactor is warming up at an accelerated pace.")
	await wait(1, true)
	GUI.append_main_screen_text("\n\nFear not! I will just limit the power of some unnecessary auxiliary systems.")
	await wait(1, true)
	
	task_count = 8
	GUI.append_main_screen_text("\n\nPlease complete the " + str(task_count) + " tasks displayed in the right panel in the correct order.")
	await wait(0, true)
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
		current_task_sequence[i] = current_task_sequence[i].replace("XXX", str(randi_range(1,4)))
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
