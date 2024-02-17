extends Node

signal activate_player
signal new_round_signal
signal new_stage_signal
signal end_game_hud
signal end_game_ctrl
signal all_objectives_done

var round_counter
var is_first_stage

# Called when the node enters the scene tree for the first time.
func _ready():
	is_first_stage = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_start():
	# instantiate everything
	round_counter = 0
	activate_player.emit(true)

# signal timeout + player killed
func check_end_round():
	if round_counter >= 6:
		#TODO give winner as input
		check_end_game()
	else:
		new_round()

# signal all_objectives_done
func check_end_game():
	if is_first_stage:
		new_stage()
	else:
		launch_end_game()
	

func new_round():
	round_counter += 1
	new_round_signal.emit()
	
func new_stage():
	is_first_stage = false
	new_stage_signal.emit()

func launch_end_game():
	#TODO define who has won
	var crt_player = "jin"
	end_game_hud.emit(crt_player)
	end_game_ctrl.emit(false) # is_player_active

func _on_trap_event_hit():
	new_round()


func _on_hud_end_timeout():
	new_round()


func _on_trap_own_hit_own():
	new_round()
