# Extends Generic State Machine Script 
# Ryan Scott © 2024

extends StateMachine
class_name SMMenu

# Initialize states (this will change depending on what is using the StateMachine)
enum States {
	MAIN_MENU, 
	IN_GAME, 
	GAME_OVER, 
	RESTART
}

var state:States = States.MAIN_MENU


func _init():
	setup_states(States.keys())
	Console.demo()

	print(_States)
