extends Node2D

#TODO : map key when defined (keyboard, controller, ...)
#TODO : connect to existing signals (players move, trap landing and activation. Which player is active is managed here)

enum player_name {JEC, JIN}
enum input_move {LEFT = 0, RIGHT = 1, JUMP = 2}

signal move_jec(left, right, jump)
signal land_trap_jec()
signal activate_shared_jec(trap_id)
signal activate_event_jec(trap_id)
signal activate_own_jec(trap_id)
signal move_jin(left, right, jump)
signal land_trap_jin()
signal activate_shared_jin(trap_id)
signal activate_event_jin(trap_id)
signal activate_own_jin(trap_id)

var activ_player
@export var is_player_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	activ_player = player_name.JEC

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_input = [0,0,0]	#left, right, jump : --> boolean, 1 if trigger
	if is_player_active:
		if Input.is_action_just_pressed("hello_there"):
			toggle_crt_player()
		if activ_player == player_name.JEC:
			if Input.is_action_pressed("jec_left"):
				move_input[input_move.LEFT] = 1
			if Input.is_action_pressed("jec_right"):
				move_input[input_move.RIGHT] = 1
			if Input.is_action_pressed("jec_jump"):
				move_input[input_move.JUMP] = 1
			if Input.is_action_just_pressed("jec_land_trap"):
				emit_signal("land_trap_jec")
			#TODO : manage multipleinput associated with same action. If not possible, create multiple signals
			if Input.is_action_just_pressed("jec_shared_trap_activation"):
				emit_signal("activate_shared_jec", 0)
			if Input.is_action_just_pressed("jec_event_trap_activation"):
				emit_signal("activate_event_jec", 0)
			if Input.is_action_just_pressed("jec_own_trap_activation"):
				emit_signal("activate_own_jec", 0)
			emit_signal("move_jec", move_input[0], move_input[1], move_input[2])
		else:
			if Input.is_action_pressed("jin_left"):
				move_input[input_move.LEFT] = 1
			if Input.is_action_pressed("jin_right"):
				move_input[input_move.RIGHT] = 1
			if Input.is_action_pressed("jin_jump"):
				move_input[input_move.JUMP] = 1
			if Input.is_action_just_pressed("jin_land_trap"):
				emit_signal("land_trap_jin")
			if Input.is_action_just_pressed("jin_shared_trap_activation"):
				emit_signal("activate_shared_jin", 0)
			if Input.is_action_just_pressed("jin_event_trap_activation"):
				emit_signal("activate_event_jin", 0)
			if Input.is_action_just_pressed("jin_own_trap_activation"):
				emit_signal("activate_own_jin", 0)
			emit_signal("move_jin", move_input[0], move_input[1], move_input[2])

#TODO : obective completion and destruction are managed with input? If so add some code here
#			Can be a simple timer upon being in the zone

func toggle_player_activity(is_active):
	is_player_active = is_active

func toggle_crt_player():
	if activ_player == player_name.JEC:
		activ_player = player_name.JIN
	else:
		activ_player = player_name.JEC


func _on_game_manager_new_stage_signal():
	toggle_crt_player()


func _on_game_manager_new_round_signal():
	toggle_crt_player()
