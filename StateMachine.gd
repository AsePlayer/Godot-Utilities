# Generic State Machine Script 
# Ryan Scott © 2024

extends Node
class_name StateMachine

@export var print_logs:bool = true
var _States:Dictionary = {}
var current_state


func _init():
	# Default states. These should be overriden!
	setup_states(["DEFAULT", "DEFAULT #2", "DEFAULT #3", "DEFAULT #4"])


func setup_states(states:Array):
	_States = {}                   # Reset states
	for i in range(states.size()): # Add each state
		_States[states[i]] = i     # in numerical order!
		
	current_state = 0              # Default to first state


func change_state(state):
	if _States.has(get_state_text(state)) == false: # Check if key exists before accessing it
		push_error("Failed to change to state " + get_state_text(state))
		return

	current_state = state
	if print_logs: print_rich( "[b]" + name + ":[/b]" + " Changed State -> [b][i]" + get_state_text(current_state) + "[/i][/b]")


func get_current_state():
	return current_state


func get_state_text(state):
	return str(_States.keys()[state])
