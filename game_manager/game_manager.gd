extends Node

signal activate_player
signal end_round
signal end_stage
signal end_game_hud
signal end_game_ctrl

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_start():
	# instantiate everything
	print("boup")
	activate_player.emit(true)


# signal end_round from game_manager?
func new_round():
	# swap player
	# reset shared traps
	# reset timer
	# ...
	print("test")
	pass

func detect_end_game():
	var crt_player = "jin"
	end_game_hud.emit(crt_player)
	end_game_ctrl.emit(false) # is_player_active

func _on_trap_event_hit():
	new_round()


func _on_hud_end_timeout():
	new_round()


func _on_trap_own_hit_own():
	new_round()
