extends Node

signal activate_player
signal new_round_signal
signal new_stage_signal
signal end_game_hud
signal end_game_ctrl
signal all_objectives_done
signal update_hud

var round_counter
var is_first_stage

var score_jec
var score_jin
var current_player_is_jec = true

# Called when the node enters the scene tree for the first time.
func _ready():
	is_first_stage = true
	score_jec = 0
	score_jin = 0
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_start():
	# instantiate everything
	round_counter = 0
	activate_player.emit(true)
	$"../Hud".start_timer()

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
	round_counter = 0
	new_stage_signal.emit()
	print("-------------new stage--------------")

func launch_end_game():
	#TODO define who has won
	var crt_player = "jin"
	end_game_hud.emit(crt_player)
	end_game_ctrl.emit(false) # is_player_active

func _on_trap_event_hit():
	check_end_round()

func _on_hud_end_timeout():
	check_end_round()

func _on_trap_own_hit_own():
	check_end_round()

func _on_objective_zone_manager_player_won_points():
	if current_player_is_jec:
		score_jec += 1
	else:
		score_jin += 1
	emit_signal("update_hud", score_jec, score_jin)
