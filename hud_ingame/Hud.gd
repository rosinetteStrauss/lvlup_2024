extends CanvasLayer

signal end_timeout

var countdown_timeout = -1

func _ready():
	countdown_timeout = $game_timer.get_wait_time()
	$display_timer.set_text("Timer: " + str(countdown_timeout))

func _on_game_timer_timeout():
	end_timeout.emit()

func _on_second_timer_timeout():
	countdown_timeout -= 1
	if countdown_timeout == 0:
		pass
	update_display_timer()

func update_display_timer():
	$jec_bar.value +=1
	$jin_bar.value +=1
	$display_timer.set_text("Timer: " + str(countdown_timeout))

# TODO
# func objectif_complete(player)
# update bar progress
