extends Area2D

var associated_player_is_eco

var eco

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func is_eco():
	return eco

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func objectiv_for_eco():
	return associated_player_is_eco


func _on_body_entered(body):
	if body.name == "Jec" and is_eco():
		body.start_timer()
	if body.name == "Jin" and not(is_eco()):
		body.start_timer()


func _on_body_exited(body):
	
	if body.name == "Jec" and is_eco():
		body.reset_timer()
	if body.name == "Jin" and not(is_eco()):
		body.reset_timer()
