extends CanvasLayer

signal end_timeout

var countdown_timeout = -1
@export var ponderation = 1

func _ready():
	countdown_timeout = $game_timer.get_wait_time()
	$display_timer.set_text("Timer: " + str(countdown_timeout))

func _on_game_timer_timeout():
	end_timeout.emit()

func _on_second_timer_timeout():
	countdown_timeout -= 1
	if countdown_timeout == 0:
		pass
	#update_display_timer(0, 0)

func update_display_timer(score_left, score_right):
	$jec_bar.value += score_left * ponderation
	$jin_bar.value += score_right * ponderation
	$display_timer.set_text("Timer: " + str(countdown_timeout))


func _on_game_manager_update_hud(score_left, score_right):
	update_display_timer(score_left, score_right)

func _on_game_manager_new_round_signal():
	$jec_bar.value = 0
	$jin_bar.value = 0
	update_display_timer(0,0)
