extends CanvasLayer

var countdown_timeout = 10

func _ready():
	$game_timer.set_wait_time(countdown_timeout)
	$display_timer.set_text("Timer: " + str(countdown_timeout))

func _on_game_timer_timeout():
	# TODO: launch new round
	pass

func _on_second_timer_timeout():
	countdown_timeout -= 1
	update_display_timer()

func update_display_timer():
	$display_timer.set_text("Timer: " + str(countdown_timeout))

