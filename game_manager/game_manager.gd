extends Node

signal activate_player
signal end_round
signal end_stage
signal end_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_start():
	# instantiate everything
	print("boup")
	activate_player.emit()


# signal end_round from game_manager?
func new_round():
	# swap player
	# reset shared traps
	# reset timer
	# ...
	pass

func detect_end_game():
	var crt_player = "jin"
	end_game.emit(crt_player)
