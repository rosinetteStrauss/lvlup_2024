extends CanvasLayer

signal restart_game

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.

func show_end_screen(player_name):
	visible = true
	$CongratulationTxt.text = "Congratulation player " + player_name + "\n you won !"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_button_pressed():
	visible = false
	restart_game.emit()


func _on_exit_button_pressed():
	get_tree().quit()
