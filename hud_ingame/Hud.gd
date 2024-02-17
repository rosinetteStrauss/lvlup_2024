extends CanvasLayer

var countdown_timeout = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$game_timer.set_wait_time(countdown_timeout)
	$display_timer.set_text("Timer: " + str(countdown_timeout))
	pass # Replace with function body.

func _on_game_timer_timeout():
	pass

func _on_second_timer_timeout():
	countdown_timeout -= 1
	update_display_timer()

func update_display_timer():
	$display_timer.set_text("Timer: " + str(countdown_timeout))

