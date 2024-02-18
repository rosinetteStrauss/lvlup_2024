extends CanvasLayer

signal end_timeout

var countdown_timeout = -1
@export var ponderation = 1

func _ready():
	$SwapLabel.hide()
	countdown_timeout = $game_timer.get_wait_time()
	$game_timer.stop()
	$second_timer.stop()
	$display_timer.set_text("Timer: " + str(countdown_timeout))
	
func start_game_timers(is_started):
	$game_timer.start()
	$second_timer.start()

func _on_game_timer_timeout():
	$second_timer.stop()
	end_timeout.emit()

func _on_second_timer_timeout():
	print(countdown_timeout)
	countdown_timeout -= 1
	if countdown_timeout <= 0:
		countdown_timeout = $game_timer.get_wait_time()
	$display_timer.set_text("Timer: " + str(countdown_timeout))

func update_display_score(score_left, score_right):
	print("update score")
	$jec_bar.value += score_left * ponderation
	$jin_bar.value += score_right * ponderation	

func _on_game_manager_update_hud(score_left, score_right):
	update_display_score(score_left, score_right)

func _on_game_manager_new_round_signal():
	#$jec_bar.value = 0
	#$jin_bar.value = 0
	#update_display_timer(0,0)
	show_swap_msg()
	
func show_swap_msg(): #text
	#$SwapLabel.text = text
	$SwapLabel.show()
	$SwapLabel/SwapTimer.start()
	countdown_timeout = $game_timer.get_wait_time()
	$game_timer.start()
	$second_timer.start()

func _on_swap_timer_timeout():
	$SwapLabel.hide()
	
