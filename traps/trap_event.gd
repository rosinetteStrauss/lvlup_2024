extends RigidBody2D

signal hit

var is_in_area = false 

func _ready():
	$".".visible = false

func _on_input_manager_activate_event_jec(trap_id):
	$".".visible = true
	check_if_trapped()

func check_if_trapped():
	if is_in_area && $".".visible:
		hit.emit()
		#queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "player_manager":
		is_in_area = true
		check_if_trapped()

func _on_area_2d_body_exited(body):
	if body.name == "player_manager":
		is_in_area = false
		check_if_trapped()

